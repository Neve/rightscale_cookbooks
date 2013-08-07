maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          "Copyright RightScale, Inc. All rights reserved."
description      "RightScale Cookbooks"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "13.4.0"

# supports "centos", "~> 5.8", "~> 6.2"
# supports "redhat", "~> 5.8"
# supports "ubuntu", "~> 10.04", "~> 12.04"

depends "rightscale"
depends "sys_firewall"

recipe 'wowza::default',
  'Default recipe for Wowza demo cookbook.'

recipe 'wowza::install_server',
  'Installs Wowza Media Server.'

recipe 'wowza::setup_flash_frontend',
  'Installs  Apache, JW player and configures WMC embedded flash frontend.'

recipe 'wowza::setup_transcoder_frontend',
  'Configures WMC transcoder addon and app, adds embedded flash frontend for transcoder.'

