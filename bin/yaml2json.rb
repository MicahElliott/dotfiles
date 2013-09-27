#! /usr/bin/env ruby
# -*- encoding: UTF-8 -*-

# yaml2json — convert yaml to json
#
# Sometimes useless if Ruby objects are part of yaml.

require 'yaml'
require 'json'

puts JSON.dump(YAML.load(STDIN.read))
#puts JSON.dump( YAML.load(IO.read('package.json')) )
