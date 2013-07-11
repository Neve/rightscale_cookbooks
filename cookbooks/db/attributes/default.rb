#
# Cookbook Name:: db
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

# Default setting for DB FQDN

default[:db][:dns][:master][:fqdn] = "localhost"
default[:db][:dns][:master][:id] = 'UNBF2GER83A'
default[:db][:dns][:slave][:fqdn] = "slave-#{node[:db][:dns][:master][:fqdn]}"
default[:db][:dns][:slave][:id] = "#{node[:db][:dns][:master][:id]}:#{node[:db][:dns][:slave][:fqdn]}"
# Initial settings for client operations on application servers
default[:db][:data_dir] = "/mnt/storage"

# Default settings for database administrator user and password
default[:db][:admin][:user] = "admin"
default[:db][:admin][:password] = 'qwaszx'

# Default settings for database replication user and password
default[:db][:replication][:user] = 'rep_user'
default[:db][:replication][:password] = 'qwaszx'


# Default settings for backup lineage
default[:db][:backup][:lineage] = "rsvm-db2-backup"
default[:db][:backup][:lineage_override] = ""
default[:db][:backup][:timestamp_override ]= ''
default[:db][:backup][:primary][:master][:cron][:hour] = ''
default[:db][:backup][:primary][:slave][:cron][:hour] = ''
default[:db][:backup][:primary][:master][:cron][:minute] = ''
default[:db][:backup][:primary][:slave][:cron][:minute] = ''



# TTL limit to verify Master DB DNS TTL
default[:db][:dns][:ttl] = "60"

# Database driver class to be used based on the type of driver
default[:db][:client][:driver] = ""

# Server state variables
#
# Default value for DB status
# valid values are :initialized or :uninitialized
default[:db][:init_status] = :uninitialized

# Default value for DB master/slave check
default[:db][:this_is_master] = false

# Instance UUID and ip default values
default[:db][:current_master_uuid] = nil
default[:db][:current_master_ip] = nil


# Calculate recommended backup times for master/slave
#
#  Offset the start time by a random number.  Skip the minutes near the exact hour and 1/2 hour.  This is done to prevent
#  overloading the API and cloud providers.  If every rightscale server sent a request at the same
#  time to perform a snapshot it would be a huge usage spike.  The random start time even out these spikes.

# Generate random time
# Master and slave backup times are staggered by 30 minutes.
cron_h = rand(23)
cron_min = 5 + rand(24)

# Master backup daily at a random hour and a random minute between 5-29
default[:db][:backup][:primary][:master][:cron][:hour] = cron_h
default[:db][:backup][:primary][:master][:cron][:minute] = cron_min

# Slave backup every hour at a random minute 30 minutes offset from the master.
default[:db][:backup][:primary][:slave][:cron][:hour] = "*" # every hour
default[:db][:backup][:primary][:slave][:cron][:minute] = cron_min + 30

# DB manager type specific commands array for db_sys_info.log file
default[:db][:info_file_options] = []
default[:db][:info_file_location] = "/etc"

default[:db][:replication][:network_interface] = 'private'

default[:db][:application][:user] = 'app_user'
default[:db][:application][:password] = 'qwaszx'

default[:db][:init_slave_at_boot] = 'false'
default[:db][:force_promote] = 'false'
default[:db][:force_safety] = 'off'
default[:db][:terminate_safety] = 'off'

default[:db][:provider_type]"db_mysql_5.5"
default[:db][:dump][:database_name] = 'app_test' #TODO changevto app db name