class ForecastPartyValuesValidator < ActiveModel::Validator
  def validate(record)
    parties_sum = record.pan + record.pconv + record.pes + record.ph + record.pmc + record.pmor + record.pna +
                  record.ppm + record.prd + record.pri + record.psd + record.psm + record.pt + record.pvem

    record.errors.add(:parties_sum, 'Parties sum cannot be below 0.5') if parties_sum < 0.5
    records.errors.add(:parties_sum, 'Parties sum cannot be above 1.5') if parties_sum > 1.5
  end
end
