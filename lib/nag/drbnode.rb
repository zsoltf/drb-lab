require 'rinda/ring'

module DRbShared
  module_function

  SIGNATURE = Array.new(4) { nil }

  def read_all_data
    tuple_space.read_all SIGNATURE
  end

  def services
    server.read_all SIGNATURE
  end

  def tuple_space
    @space ||= Rinda::TupleSpaceProxy.new(server.read([:name, :TupleSpace, nil, nil])[2])
  end

  def server
    @service ||= DRb.start_service
    @server ||= Rinda::RingFinger.primary
  end
end

class DRbNode
  include DRbShared
  attr_reader :data, :started

  def initialize(check_timeout=10)
    class << self; include DRbUndumped; end
    @data = tuple_space
    @renewer = Rinda::SimpleRenewer.new(check_timeout)
    @provider = Rinda::RingProvider.new(
      to_sym, self, "#{self} DRb Node", @renewer
    ).provide
    @started = Time.now
    yield(self) if block_given?
    return self
  end

  def to_sym
    to_s.gsub(/[-.:]/, '_').to_sym
  end

  def signature(snapshot)
    data.write [:name, to_sym, self, [Time.now, snapshot]]
  end

end
