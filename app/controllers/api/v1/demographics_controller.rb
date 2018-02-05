class Api::V1::DemographicsController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback: :none

  def index
    if needed_params_present?('state', 'municipality')
      state = State.find_state_by_name(params['state'])
      muni  = state.find_state_municipality(params['municipality'])
      @demographics = Demographic.all.municipal(state.state_code, muni.muni_code, 2015)
    end
    @demographics = Demographic.where(id: 1) unless @demographics.present?

    puts DemographicSerializer.new(@demographics.first).serialized_json
    render json: DemographicSerializer.new(@demographics).serialized_json
  rescue State::DataNotFound => e
    logger.error e.backtrace.first(5).join('\n')
    logger.error "*ERROR* Demographics#index -> #{e}"
  end
end
