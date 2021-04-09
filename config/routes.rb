# frozen_string_literal: true

Rails.application.routes.draw do
  get '/readiness' => 'health#readiness'
  get '/healthiness' => 'health#healthiness'
end
