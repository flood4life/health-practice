# frozen_string_literal: true

class RedisConnection
  def initialize
    config = RedisConfig.new
    @conn = Redis.new(
      host: config.host,
      port: config.port,
      username: config.user,
      password: config.password,
      db: config.default_db
    )
  end

  def get
    @conn
  end
end
