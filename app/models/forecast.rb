class Forecast < ApplicationRecord
  validates_with ForecastCodesValidator
  validates :pan,
            :pconv,
            :pes,
            :ph,
            :pmc,
            :pmor,
            :pna,
            :ppm,
            :prd,
            :pri,
            :psd,
            :psm,
            :pt,
            :pvem, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 1.0 }
end
