#
# Cookbook Name:: wowza
#

rightscale_marker

execute 'Get wowza bin' do
  command "/usr/bin/wget 172.20.0.1/static/wowza-demo/#{node[:wowza][:install_bin]} --no-check-certificate -P /tmp"
end

file "/tmp/#{node[:wowza][:install_bin]}" do
  mode '0755'
  action :touch
end

package 'default-jre'

execute 'Update ulimit to required value' do
  command 'ulimit -n 20000 > /dev/null 2>&1'
end

execute 'Set JMXOPTIONS env' do
  command 'export JMXOPTIONS=-Dcom.sun.management.jmxremote=true'
end

#execute 'Install Wowza MS' do
#  command "echo -ne 'yes' | /tmp/#{node[:wowza][:install_bin]} >> /tmp/wms_install.log"
#end

bash "Install apache passenger module" do
  flags "-ex"
  code <<-EOH
    echo -ne 'yes' | /tmp/#{node[:wowza][:install_bin]} >> /tmp/wms_install.log
  EOH
end

template '/usr/local/WowzaMediaServer/conf/Server.license' do
  mode '0744'
  source 'wowza_server.license.erb'
  cookbook 'wowza'
  variables(
    :license_num => RightScale::Utils::Helper.load_vars('wowza_ms_lic')
  )
end

execute 'Set wowza environment' do
  command './setenv.sh'
  cwd '/usr/local/WowzaMediaServer/bin'
end


service 'WowzaMediaServer' do
  action :restart
end

public_ip = node[:cloud][:private_ips][1]
private_ip = node[:cloud][:private_ips][0]

if  RightScale::Utils::Helper.is_valid_ip?(public_ip)
  node[:wowza][:ip] = public_ip
elsif RightScale::Utils::Helper.is_valid_ip?(private_ip)
  node[:wowza][:ip] = private_ip
else
  raise "No valid public/private IP found for the server."
end

unique_tag = "wowza_media_server:stream=rtsp://#{node[:wowza][:ip]}:1935/vod/mp4:sample.mp4"
log "  Tagging server with #{unique_tag}"
right_link_tag unique_tag
