class ProjectionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :section_code, :muni_code, :state_code, :district_code,
             :election_type, :year, :nominal_list, :total_votes,
             :pan, :pconv, :pes, :ph, :pmc, :pmor, :pna, :ppm,
             :prd, :pri, :psd, :psm, :pt, :pvem
end
