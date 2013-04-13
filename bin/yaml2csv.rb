#! /usr/bin/env ruby
# -*- encoding: UTF-8 -*-

# yaml2csv — convert YAML to CSV; should not be nested
# Too specific to this data set to be general purpose.

# tandem: 
#   created_at: 2011-09-15 19:08:02 Z
#   last_seen_at: 2013-03-08 18:50:35 Z
#   likely_start_date: 2011-09-19 13:20:47 Z
# mirman: 
#   created_at: 2012-11-30 20:49:20 Z
#   last_seen_at: 2013-03-14 20:29:11 Z
#   likely_start_date: 2012-12-04 18:59:47 Z

# tandem,2012-11-30,2012-11-30,2012-11-30
# mirman,2012-11-30,2012-11-30,2012-11-30

require 'yaml'

ys = YAML.load_file ARGV[0]
#ys.each_pair {|k,v| puts "#{k},#{v.values.join(',')}" }
ys.each_pair do |k,v|
  print "#{k},"
  puts v.values.map {|d| d ? d.strftime('%Y-%m-%d') : '' }.join(',')
end
