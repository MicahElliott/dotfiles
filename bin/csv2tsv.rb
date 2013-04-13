#! /usr/bin/env ruby
# -*- encoding: UTF-8 -*-

# csv2tsv — convert CSV to TSV to improve readability

require 'csv'

#CSV.foreach(ARGV[0]) do |row|
#lines = $stdin.readlines
s = $stdin.read
#puts lines[3]
#exit
CSV.parse(s) do |row|
  puts row.join "\t"
  #puts row
end
