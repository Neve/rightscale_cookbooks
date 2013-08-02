#
# Cookbook Name:: wowza
#

rightscale_marker

# Open required ports for wowza MS
node[:wowza][:rule][:ports].each do |port|
  sys_firewall port do
    ip_addr 'any'
    protocol 'tcp'
    enable true
    action :update
  end
end

