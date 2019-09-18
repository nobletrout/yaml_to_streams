#!/usr/bin/env ruby
# vim: ts=2 sts=2 et
# converty wireshark yaml to something you can use...
# will combine one two or more transmit packets from one transmit node into one file block
# useful for things that wireshark doesn't know how to export, since it'll shove each transmission block into it's
# own YAML node

# example:
# if a protocol sends multiple packets in a TCP stream that combine into one "block" (say SMB or telnet or something) then this
# will collapse it into one file

# this does not solve the problems of timing or heartbeats or things.
# need a parameter for a file
(puts 'I NEED A PARAMETER'; exit(1) ) if ARGV.length < 1
NO_COLLAPSY = ARGV.length == 2 ? true : false
require 'yaml'
require 'base64'

begin
  foo = YAML.load_file(ARGV[0])
rescue => e
  puts 'failed to load YAML file'
  puts "Here's your reason: #{e}"
  exit(1)
end

prev = foo.keys.first.split('_').first
index = 0
rjustval = 2
foo.each do |key, value|
  if prev == key.split('_').first && !NO_COLLAPSY
    # handle last piece
    if foo.keys.last == key
      File.write('trans_' + index.to_s.rjust(rjustval, '0') + '_' + prev, value)
    end
  else
    puts "Adding new transaction index: #{index}.\r\n prev: #{prev}\r\n buff: #{Base64.encode64(value)}\r\n"
    File.write('trans_' + index.to_s.rjust(rjustval, '0') + '_' + prev, value)
    prev = key.split('_').first
    index += 1
  end
end
