# A script for exporting all starred items from Google Reader to Evernote,
# using exported [starred.json] from Google's Takeout

#! /usr/bin/env ruby

require 'rubygems'
require 'json'


if File.exists?("starred.json")

  file = open("starred.json", "r:utf-8")
  json = file.read
  parsed = JSON.parse(json)

  parsed["items"].each_with_index {|item,i|

      file_name = "#{i}" + ".html"
      enex = File.open(file_name, "w+")
      enex.puts '<head><meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>'
      enex.puts item["content"]["content"] unless item["content"].nil?

  }

else
  STDERR.print "ERROR: starred.json does not exist\n"
  exit 1
end
