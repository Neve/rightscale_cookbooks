#
# Cookbook Name:: rightscale
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

# RightScale Environment Attributes.
# These are needed by all RightScale Cookbooks.
# rightscale should be included in all server templates so these attributes are declared here.


# Optional attributes
#
# Wowza Media Server instaaltin bin name and version
default[:wowza][:install_bin] = 'WowzaMediaServer-3.6.2.deb.bin'

# TCP 1935 RTMP/ RTMPE/ RTMPT/RTSP - interleaved streaming /WOWZ™
# TCP 8084-8085 JMX/JConsole monitoring and a dministration
# TCP 8086 Administration
default[:wowza][:rule][:ports] = ['1935','8084','8085','8086',]
default[:wowza][:ip] = node[:cloud][:private_ips][0]

default[:wowza][:app_path] = '/usr/local/WowzaMediaServer'