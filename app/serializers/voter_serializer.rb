class VoterSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :electoral_id_number, 
             :expiration_date, :first_name, :first_last_name, 
             :second_last_name, :gender,   :date_of_birth, :electoral_code, 
             :curp, :section, :street, :outside_number, :inside_number, 
             :suburb, :locality_code, :locality, :municipality_code, 
             :municipality, :state_code, :state, :postal_code, :home_phone, 
             :mobile_phone, :email, :alternative_email, :facebook_account, 
             :highest_educational_level, :current_ocupation, :organization, 
             :party_positions_held, :is_part_of_party, :has_been_candidate, 
             :popular_election_position, :election_year, :won_election, :election_route, :notes
end