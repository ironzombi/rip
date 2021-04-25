#!/usr/bin/env ruby
require 'socket'
# /* Version 0.01 v0.1 will be initial release  */
# default behaviour - called with no args list available interfaces
unless ARGV[0]
  puts "Available Interfaces: \n"
  Socket.getifaddrs.map do |iface|
    next unless iface.addr.ipv4?

    puts '' + iface.name
    # puts "\Address:          : " + iface.addr.ip_address
  end
  return
end
# when ip l - list the interfaces #TODO make this different than default

def ip_names
  Socket.getifaddrs.map do |ifnames|
    next unless ifnames.addr.ipv4?

    puts '' + ifnames.name
  end
end
# when ip a - list the interfaces and Addresses #TODO add netmask, maybe more ?

def ip_all
  Socket.getifaddrs.map do |iface|
    next unless iface.addr.ipv4?

    puts "\nName:             :" + iface.name
    puts 'Address:          : ' + iface.addr.ip_address
    puts 'Broadcast:         : ' + iface.addr.broadaddr
  end
end
# main-------
case ARGV[0]
when 'a', 'A', '-a', '-A'
  ip_all
when 'l', 'L', '-l', '-L'
  ip_names
else
  puts 'Command not recognized'
end
