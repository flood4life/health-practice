# frozen_string_literal: true

class HealthChecker
  Status = Struct.new(:healthy, :services, keyword_init: true)
  Services = Struct.new(:mongodb, :redis, keyword_init: true)

  def initialize
    @mongodb_client = Mongoid.default_client
    @redis_conn = RedisConnection.new.get
  end

  def status
    services = services_status
    Status.new(
      healthy: services.values.all?,
      services: services
    )
  end

  private

  attr_reader :mongodb_client, :redis_conn

  def services_status
    Services.new(
      mongodb: mongodb_status,
      redis: redis_status
    )
  end

  def mongodb_status
    # the application can't function if it can't write to DB
    mongodb_client.cluster.has_writable_server?
  end

  def redis_status
    # we consider redis to be fine if it responds to our pings
    redis_conn.ping == 'PONG'
  rescue Redis::BaseError => _e
    false
  end
end
