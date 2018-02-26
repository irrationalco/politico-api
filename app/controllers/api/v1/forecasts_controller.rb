class Api::V1::ForecastsController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback: :none

  # GET /forecasts
  def index
    forecasts = Forecast.where(forecast_type: 1)

    render json: ForecastSerializer.new(forecasts).serialized_json
  end
end
