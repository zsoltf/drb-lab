#!/usr/bin/env ruby -w

require 'rinda/ring'

DRb.start_service
ring_server = Rinda::RingFinger.primary

ts = ring_server.read([:name, :TupleSpace, nil, nil])[2]
ts = Rinda::TupleSpaceProxy.new ts

loop do
  ts.write([:nag, `hostname`.chomp, Time.now, :alive, nil])
  sleep 1
end
