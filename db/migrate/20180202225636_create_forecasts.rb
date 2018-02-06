class CreateForecasts < ActiveRecord::Migration[5.0]
  def change
    create_table :forecasts do |t|
      t.integer :section_code, default: 0
      t.integer :muni_code, default: 0
      t.integer :state_code, default: 0
      t.integer :district_code, default: 0
      t.string  :election_type
      
      t.integer :forecast_type, default: 0

      t.float :PAN, default: 0.0
      t.float :PCONV, default: 0.0
      t.float :PES, default: 0.0
      t.float :PH, default: 0.0
      t.float :PMC, default: 0.0
      t.float :PMOR, default: 0.0
      t.float :PNA, default: 0.0
      t.float :PPM, default: 0.0
      t.float :PRD, default: 0.0
      t.float :PRI, default: 0.0
      t.float :PSD, default: 0.0
      t.float :PSM, default: 0.0
      t.float :PT, default: 0.0
      t.float :PVEM, default: 0.0

      t.timestamps
    end
  end
end
