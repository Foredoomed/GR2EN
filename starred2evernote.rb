# A script for exporting all starred items from Google Reader to Evernote,
# using exported [starred.json] from Google's Takeout

#! /usr/bin/env ruby

require 'rubygems'
require 'json'



footer = '</en-note>]]></content></note>'



if File.exists?("starred.json")
  if File.exists?("starred.enex")
    File.delete("starred.enex")
  end

  enex = File.open("starred.enex", "w")

  enex.puts '<?xml version="1.0" encoding="UTF-8"?>'

  file = open("starred.json", "r:utf-8")
  json = file.read
  parsed = JSON.parse(json)
  parsed["items"].take(1).each do |item|
    enex.print '<note><title>'
    enex.print item["title"]
    enex.print '</title><content>'
    enex.print '<![CDATA[<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
    enex.puts '<!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd">'
    enex.puts '<en-note>'
    temp = item["content"]["content"]
    enex.puts temp.gsub(/([<>])/, " ")
  end
    enex.puts footer
else
  STDERR.print "ERROR: starred.json does not exist\n"
  exit 1
end
