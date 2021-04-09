# frozen_string_literal: true

class HealthController < ApplicationController
  # an endpoint to check whether the service is ready to accept HTTP connections
  def readiness
    head :ok
  end

  # an endpoint to check whether the core dependencies of the application are available
  def healthiness
    status = HealthChecker.new.status
    response_code = status.healthy ? 200 : 503

    render json: status, status: response_code
  end
end
