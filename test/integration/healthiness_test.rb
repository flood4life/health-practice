# frozen_string_literal: true

require 'test_helper'

class HealthinessTest < ActionDispatch::IntegrationTest
  def test_mongo_and_redis_up
    get '/healthiness'
    assert_response :success
    expected_response = { healthy: true, services: { mongodb: true, redis: true } }.as_json
    assert_equal(expected_response, response.parsed_body)
  end

  def test_mongo_up_redis_down
    with_redis_down do
      get '/healthiness'
      assert_response :service_unavailable
      expected_response = { healthy: false, services: { mongodb: true, redis: false } }.as_json
      assert_equal(expected_response, response.parsed_body)
    end
  end

  def test_mongo_down_redis_up
    with_mongo_down do
      get '/healthiness'
      assert_response :service_unavailable
      expected_response = { healthy: false, services: { mongodb: false, redis: true } }.as_json
      assert_equal(expected_response, response.parsed_body)
    end
  end

  def test_mongo_and_redis_down
    with_mongo_down do
      with_redis_down do
        get '/healthiness'
        assert_response :service_unavailable
        expected_response = { healthy: false, services: { mongodb: false, redis: false } }.as_json
        assert_equal(expected_response, response.parsed_body)
      end
    end
  end

  private

  def with_redis_down(&block)
    redis_mock = Minitest::Mock.new
    def redis_mock.ping
      raise Redis::BaseError
    end

    Redis.stub :new, redis_mock do
      block.call
    end
  end

  def with_mongo_down(&block)
    mongo_mock = Minitest::Mock.new
    def mongo_mock.has_writable_server?
      false
    end

    Mongo::Cluster.stub :new, mongo_mock do
      block.call
    end
  end
end
