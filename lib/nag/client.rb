#!/usr/bin/env ruby -w

require './drbnode'

class NagClient
  def initialize
    @hostname = `hostname`.strip
    @pid = Process.pid
  end

  def to_s
    "#@hostname-#@pid"
  end

  def ps
    `ps aux`
  end

  def snapshot
    `top | head -n 4`.split("\n").map(&:strip)
  end
end

nag = NagClient.new
DRbNode.new(nag) do |node, client|

  loop do
    node.data.write [:nag, Time.now, client, client.snapshot]
    sleep 1
  end

end

puts 'done'
