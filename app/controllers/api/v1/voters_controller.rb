class Api::V1::VotersController < ApplicationController
  acts_as_token_authentication_handler_for User, fallback: :none
  before_action :set_voter, only: %i[show update destroy]
  before_action :set_current_user_by_token, only: [:index]

  # GET /voters
  def index
    # TODO: Encapsulate in a function
    @voters = if @current_user.is_superadmin?
                Voter.all
              elsif @current_user.is_manager?
                Voter.where(suborganization_id: @current_user.suborganization_id)
              else
                Voter.where(user: params[:uid].to_i)
              end

    @voters = Voter.all

    @voters = @voters.order(created_at: :desc)

    if params['q'].present?
      @q = @voters.ransack(
        first_name_cont:          params[:q],
        first_last_name_cont:     params[:q],
        second_last_name_cont:    params[:q],
        state_cont:               params[:q],
        municipality_cont:        params[:q],
        electoral_code_cont:      params[:q],
        electoral_id_number_cont: params[:q],
        m: 'or'
      )
      @voters = @q.result(distinct: true)
    end

    if params['per_page'].present? && params['page'].present?
      @voters = @voters.page(params['page']).per(params['per_page'])
      options = { meta: { total: @voters.total_pages } }
      render json: VoterSerializer.new(@voters, options).serialized_json
    else
      render json: VoterSerializer.new(@voters).serialized_json
    end
  end

  def file_upload
    begin
      invalid_rows = Voter.import(params[:file], params[:user_id].to_i)
    rescue StandardError
      render status: :no_content
      return
    end
    if invalid_rows.nil?
      render status: :created
    else
      send_data invalid_rows, filename: "registrosInvalidos-#{Date.today}.csv", type: :csv, status: :partial_content
    end
  end

  # GET /voters/1
  def show
    render json: VoterSerializer.new(@voter).serialized_json
  end

  # POST /voters
  def create
    @voter = Voter.new(voter_params)
    user = User.find_by(id: voter_params[:user_id])
    @voter[:suborganization_id] = user[:suborganization_id] if user

    if @voter.save
      render json: VoterSerializer.new(@voter).serialized_json
    else
      render json: @voter.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /voters/1
  def update
    if @voter.update(voter_params)
      render json: VoterSerializer.new(@voter).serialized_json
    else
      render json: @voter.errors, status: :unprocessable_entity
    end
  end

  # DELETE /voters/1
  def destroy
    @voter.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_voter
    @voter = Voter.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def voter_params
    params.require(:data)
          .require(:attributes)
          .permit(:user_id, :electoral_id_number, :expiration_date, :emission_year, :first_name,
                  :first_last_name, :second_last_name, :gender, :date_of_birth, :electoral_code,
                  :curp, :state, :municipality, :locality, :section, :suburb, :street, :outside_number,
                  :inside_number, :postal_code, :state_code, :municipality_code, :locality_code,
                  :home_phone, :mobile_phone, :email, :alternative_email, :facebook_account,
                  :highest_educational_level, :current_ocupation, :organization, :party_positions_held,
                  :is_part_of_party, :has_been_candidate, :popular_election_position, :election_year,
                  :won_election, :election_route, :notes)
  end
end
