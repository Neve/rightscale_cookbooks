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

recipe "wowza::default",
  "Default recipe for Wowza demo cookbook."
