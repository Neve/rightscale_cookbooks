#
# Cookbook Name:: wowza
#

rightscale_marker


package 'apache2'

#execute 'move player files to web root' do
#  command 'cp -r /usr/local/WowzaMediaServer/examples/VideoOnDemandStreaming/FlashHTTPPlayer/ /var/www/'
#end

execute 'Download jwplayer 6.5' do
  command '/usr/bin/wget http://account.longtailvideo.com/static/download/jwplayer-6.5.zip -P /tmp'
end

execute 'Unpack jwplayer to web root' do
  command 'unzip -o /tmp/jwplayer-6.5.zip -d /var/www/'
end

public_ip = node[:cloud][:public_ips][0]
private_ip_1 = node[:cloud][:private_ips][1]

if  RightScale::Utils::Helper.is_valid_ip?(public_ip)
  node[:wowza][:ip] = public_ip
elsif RightScale::Utils::Helper.is_valid_ip?(private_ip_1)
  node[:wowza][:ip] = private_ip_1
else
  node[:wowza][:ip] =  node[:cloud][:private_ips][0]
end

template '/var/www/index.html' do
  mode '0744'
  source 'index.html.erb'
  cookbook 'wowza'
  variables(
    :host => node[:wowza][:ip]
  )
end


service 'apache2' do
  action :restart
end

#unique_tag = "wowza_media_server:flash_stream=http://#{node[:wowza][:ip]}/FlashHTTPPlayer/player.html"
unique_tag = "wowza_ms:flash_stream=http://#{node[:wowza][:ip]}/index.html"
log "  Tagging server with #{unique_tag}"
right_link_tag unique_tag

