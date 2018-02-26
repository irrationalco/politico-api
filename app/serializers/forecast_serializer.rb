class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :section_code, :muni_code, :state_code, :district_code,
             :forecast_type, :pan, :pconv, :pes, :ph, :pmc, :pmor, :pna, :ppm,
             :prd, :pri, :psd, :psm, :pt, :pvem
end
