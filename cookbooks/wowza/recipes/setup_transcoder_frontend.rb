#
# Cookbook Name:: wowza
#

rightscale_marker

class Chef::Recipe
  include RightScale::Utils::Helper
end

class Chef::Resource
  include RightScale::Utils::Helper
end

# Install WMC live application

# Create WMC app directory
directory  "#{node[:wowza][:app_path]}/applications/live/"


directory  "#{node[:wowza][:app_path]}/conf/live/"


cookbook_file "#{node[:wowza][:app_path]}/conf/live/Application.xml" do
  mode '0744'
  source 'transcode_Application.xml'
  cookbook 'wowza'
end

template "#{node[:wowza][:app_path]}/content/mystream.stream" do
  mode '0744'
  source 'rtmp_stream.stream.erb'
  cookbook 'wowza'
  variables(
    :host => get_instance_ip('private')
  )
end

cookbook_file "#{node[:wowza][:app_path]}/content/logo_altoros.gif" do
  mode '0744'
  source 'transcode_logo_altoros.gif'
  cookbook 'wowza'
end

template "#{node[:wowza][:app_path]}/conf/StartupStreams.xml" do
  mode '0744'
  source 'transcode_StartupStreams.xml.erb'
  cookbook 'wowza'
  variables(
    :stream_name => 'mystream.stream'
  )
end

cookbook_file "#{node[:wowza][:app_path]}/transcoder/templates/transrate.xml" do
  mode '0744'
  source 'transcode_transrate.xml'
  cookbook 'wowza'
end

node[:wowza][:ip] = get_instance_ip('public')

template '/var/www/transcode.html' do
  mode '0744'
  source 'transcode.html.erb'
  cookbook 'wowza'
  variables(
    :host => node[:wowza][:ip]
  )
end

service 'apache2' do
  action :restart
end

service 'WowzaMediaServer' do
  action :restart
end

#unique_tag = "wowza_media_server:flash_stream=http://#{node[:wowza][:ip]}/FlashHTTPPlayer/player.html"
unique_tag = "wowza_ms:transcode_stream=http://#{node[:wowza][:ip]}/transcode.html"
log "  Tagging server with #{unique_tag}"
right_link_tag unique_tag