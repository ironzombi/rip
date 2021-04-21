#!/usr/bin/env ruby
require 'socket'
/* Version 0.01 v0.1 will be initial release  */
unless ARGV[0]
  puts "Available Interfaces: \n"
  Socket.getifaddrs.map do |iface|
    next unless iface.addr.ipv4?
    puts "" + iface.name
    #puts "\Address:          : " + iface.addr.ip_address
  end
  return
end

def ip_names
  Socket.getifaddrs.map do |ifnames|
    next unless ifnames.addr.ipv4?
    puts "" + ifnames.name
  end
end


def ip_all
  Socket.getifaddrs.map do |iface|
    next unless iface.addr.ipv4?
    puts "\nName:             :" + iface.name
    puts "\nAddress:          :" + iface.addr.ip_address
  end
end

case ARGV[0]
when "a"||"A"
  ip_all
else
  puts "error roror"
end
