#!/usr/bin/env ruby -w

require 'rinda/ring'
require 'awesome_print'

DRb.start_service
ring_server = Rinda::RingFinger.primary

ts = ring_server.read([:name, :TupleSpace, nil, nil])[2]
ts = Rinda::TupleSpaceProxy.new ts

loop do
  data = ts.read_all([:nag, nil, nil, nil, nil])
  if data.empty?
    puts "No Clients Connected"
  else
    puts "Monitoring Data"
    ap data.group_by {|e| e[1] }.map {|k,v| Hash[k, v.last]}
  end
  sleep 2
  system("clear")
end
