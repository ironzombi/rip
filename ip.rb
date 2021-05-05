#!/usr/bin/env ruby -w
require 'socket'
require 'rbconfig'

# /* Version 0.04 -- v0.1 will be initial release  */
# default behaviour - called with no args lists available interfaces
unless ARGV[0]
  puts "Available Interfaces: \n"
  Socket.getifaddrs.map do |iface|
    next unless iface.addr.ipv4?

    puts "  #{iface.name}"
    # puts "\Address:          : " + iface.addr.ip_address
  end
  return
end

# ip -l list interface names
def ip_names
  Socket.getifaddrs.map do |ifnames|
    next unless ifnames.addr.ipv4?

    puts "  #{ifnames.name}"
  end
end

# ip -a lists interface name and address(s)
def ip_all
  Socket.getifaddrs.map do |iface|
    next unless iface.addr.ipv4?

    puts "\nName:             :  #{iface.name}"
    puts "Address:          :' + #{iface.addr.ip_address}"
  end
end

# ip -n list netmask
def bcast_info
  Socket.getifaddrs.map do |iface|
    next unless iface.addr.ipv4?

    output = iface.name + ':' + iface.inspect
    int = ('Address:' + ' ' + output.split[1] + '   ' + output.split[3..4].to_s)
    puts int.gsub('?', '0')
  end
end

# ok this ended up broadcast info....err ok
def intface_info
  Socket.getifaddrs.map do |iface|
    next unless iface.addr.ipv4?

    p iface.netmask
  end
end

# checks what OS, - code from selenium
def check_os
  @os ||= (
    host_os = RbConfig::CONFIG['host_os']
    case host_os
    when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
      :windows
    when /darwin|mac os/
      :macosx
    when /linux/
      :linux 
    when /solaris|bsd/
      :unix
    else
      raise Error::WebDriverError, "unknown os: {host_os.inspect}"
    end
  )
end

# ip -h show the usage
def show_help
  puts 'usage: '
  puts 'a, -a             :List all interfaces and their Addresses'
  puts 'l, -l             :List all interface names'
  puts 'n, -n             :List interface netmask settings'
  puts 'b, -b             :List interface broadcast info....err'
  puts 'h, -h             :Show this message'
  puts 'o, -o             :Show operating system'
end

# main-------
check_os
puts @os 
case ARGV[0]
when 'a', 'A', '-a', '-A'
  ip_all
when 'l', 'L', '-l', '-L'
  ip_names
when 'n', 'N', '-n', '-N'
  bcast_info
when 'b', 'B', '-b', '-B'
  intface_info
when 'h', 'H', '-h', '-H'
  show_help
when 'o', 'O', '-o', '-O'
  check_os 
else
  puts 'Command not recognized'
  exit
end
