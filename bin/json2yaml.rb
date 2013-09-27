#! /usr/bin/env ruby
# -*- encoding: UTF-8 -*-

# json2yaml — convert json to yaml

require 'yaml'
require 'json'

puts YAML.dump(JSON.parse(STDIN.read))
