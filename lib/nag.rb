require "nag/version"
require "nag/drbnode"

class Nag::Client
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
