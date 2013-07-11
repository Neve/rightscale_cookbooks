#
# Cookbook Name:: sys
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements such
# as a RightScale Master Subscription Agreement.

rightscale_marker

node.default[:sys][:reconverge_list] = 'rightscale::setup_security_updates'
node.default[:sys][:reconverge_interval] = '15'
=begin
opt_file = '/var/cache/rightscale/inst_opts'

if File.exists?(opt_file)
   File.readlines(opt_file).each do |line|
     if line.include?('sys_reconverge_list')
       val=line.split("=")
       node[:sys][:reconverge_list] = val[1]
     end
   end
 end
=end

node[:sys][:reconverge_list] = RightScale::System::Helper.load_vars('sys_reconverge_list')
node[:sys][:reconverge_interval] = RightScale::System::Helper.load_vars('sys_reconverge_interval')
log "  !!! DEBUG  #{node[:sys][:reconverge_list]}"
log "  !!! DEBUG #{node[:sys][:reconverge_interval]} "


# Add re-converge task for all recipes provided in
# the space-separated reconverge_list


node[:sys][:reconverge_list].split(" ").each do |recipe|

  log "  Adding re-converge task for #{recipe}"

  # This block calls the enable action of cookbooks/sys/providers/default.rb
  # by passing in the recipe name and optional interval as the parameter.
  sys_reconverge "Enable recipe re-converge" do
    recipe_name recipe
    interval node[:sys][:reconverge][:interval].to_i
    action :enable
  end

end if node[:sys]
