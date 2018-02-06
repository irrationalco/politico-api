class ForecastPartyValuesValidator < ActiveModel::Validator
  def validate(record)
    parties_sum = record.PAN + record.PCONV + record.PES + record.PH + record.PMC + record.PMOR + record.PNA
                  record.PPM + record.PRD + record.PRI + record.PSD + record.PSM + record.PT + record.PVEM

    if parties_sum < 0.5
      record.errors.add(:parties_sum, 'Parties sum cannot be below 0.5')
    end

    if parties_sum > 1.5
      records.errors.add(:parties_sum, 'Parties sum cannot be above 1.5')
    end
  end
end