class StateCacheSerializer < ActiveModel::Serializer
  attributes :id, :state_code, :election_type, :year, :total_votes,
             :pan, :pconv, :pes, :ph, :pmc, :pmor, :pna, :ppm,
             :prd, :pri, :psd, :psm, :pt, :pvem
end
