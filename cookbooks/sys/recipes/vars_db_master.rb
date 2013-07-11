#
# Cookbook Name:: sys
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements such
# as a RightScale Master Subscription Agreement.

rightscale_marker
# init template dependant vars since we cannot use inputs

node.default[:sys][:reconverge_list] = 'db::do_appservers_allow'
node.default[:sys][:reconverge_interval] = '15'
