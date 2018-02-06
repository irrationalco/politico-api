class Forecast < ApplicationRecord
  validates_with ForecastCodesValidator
  validates :PAN,
            :PCONV,
            :PES,
            :PH,
            :PMC,
            :PMOR,
            :PNA,
            :PPM,
            :PRD,
            :PRI,
            :PSD,
            :PSM,
            :PT,
            :PVEM, numericality: { greater_than_or_equal_to:  0.0, less_than_or_equal_to: 1.0 }
end
