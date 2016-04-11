require "nag/version"
require "nag/drbnode"

class Nag::Client < DRbNode

  def to_s
    "#{`hostname`.strip}:#{Process.pid}"
  end

  def sign
    signature(snapshot)
  end

  def ps
    `ps aux`
  end

  def snapshot
    `top | head -n 4`.split("\n").map(&:strip)
  end

  def monitor
    Thread.new { loop { sign; sleep 1}}.join
  end
end
