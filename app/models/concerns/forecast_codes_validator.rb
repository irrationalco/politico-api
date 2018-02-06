class ForecastCodesValidator < ActiveModel::Validator
  def validate(record)
    case record.forecast_type
    when 0
      if record.state_code != 0
        record.errors.add(:state_code, 
                          'state_code must be 0 when forecast_type equals 0') 
      end
      if record.muni_code != 0
        record.errors.add(:muni_code, 
                          'muni_code must be 0 when forecast_type equals 0') 
      end
      if record.district_code != 0
        record.errors.add(:district_code, 
                          'district_code must be 0 when forecast_type equals 0') 
      end
      if record.section_code != 0
        record.errors.add(:section_code, 
                          'section_code must be 0 when forecast_type equals 0') 
      end

    when 1
      if record.state_code <= 0
        record.errors.add(:state_code, 
                          'state_code must be positive when forecast_type equals 1') 
      end
      if record.muni_code != 0
        record.errors.add(:muni_code, 
                          'muni_code must be 0 when forecast_type equals 1') 
      end
      if record.district_code != 0
        record.errors.add(:district_code, 
                          'district_code must be 0 when forecast_type equals 1') 
      end
      if record.section_code != 0
        record.errors.add(:section_code, 
                          'section_code must be 0 when forecast_type equals 1') 
      end

    when 2
      if record.state_code <= 0
        record.errors.add(:state_code, 
                          'state_code must be positive when forecast_type equals 2') 
      end
      if record.muni_code <= 0
        record.errors.add(:muni_code, 
                          'muni_code must be positive when forecast_type equals 2') 
      end
      if record.district_code != 0
        record.errors.add(:district_code, 
                          'district_code must be 0 when forecast_type equals 2') 
      end
      if record.section_code != 0
        record.errors.add(:section_code, 
                          'section_code must be 0 when forecast_type equals 2') 
      end

    when 3
      if record.state_code != 0
        record.errors.add(:state_code, 
                          'state_code must be 0 when forecast_type equals 3') 
      end
      if record.muni_code != 0
        record.errors.add(:muni_code, 
                          'muni_code must be 0 when forecast_type equals 3') 
      end
      if record.district_code <= 0
        record.errors.add(:district_code, 
                          'district_code must be positive when forecast_type equals 3') 
      end
      if record.section_code != 0
        record.errors.add(:section_code, 
                          'section_code must be 0 when forecast_type equals 3') 
      end

    when 4
      if record.state_code != 0
        record.errors.add(:state_code, 
                          'state_code must be 0 when forecast_type equals 4') 
      end
      if record.muni_code != 0
        record.errors.add(:muni_code, 
                          'muni_code must be 0 when forecast_type equals 4') 
      end
      if record.district_code <= 0
        record.errors.add(:district_code, 
                          'district_code must be positive when forecast_type equals 4') 
      end
      if record.section_code <= 0
        record.errors.add(:section_code, 
                          'section_code must be positive when forecast_type equals 4') 
      end
    end
  end
end