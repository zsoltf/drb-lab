require 'rinda/ring'

module DRbShared
  module_function

  def read_all_data
    tuple_space.read_all [nil,nil,nil,nil]
  end

  def services
    server.read_all [nil,nil,nil,nil]
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
  attr_reader :client, :data

  def initialize(client, check_timeout=10)
    class << client; include DRbUndumped; end
    @client = client
    @data = tuple_space
    @renewer = Rinda::SimpleRenewer.new(check_timeout)
    @provider = Rinda::RingProvider.new(
      client.to_s, client, "#{client} DRb Node", @renewer
    ).provide
    yield(self, client) if block_given?
    return self
  end
end
