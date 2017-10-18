#! /usr/bin/env ruby
# coding: utf-8

# user-agent — parse a log line and translate the ua string to os/browser fields

require 'user_agent_parser'

ARGF.each do |line|
  fields = line.split("\t")
  ua = UserAgentParser.parse fields.last
  puts (fields[0...(fields.length - 1)] + [ua.to_s, ua.os.to_s]).join("\t")
end
