# frozen_string_literal: true

class RedisConfig < ApplicationConfig
  attr_config :user, :password, host: 'localhost', default_db: 0, port: 6379
end
