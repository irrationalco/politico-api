class CreateForecasts < ActiveRecord::Migration[5.0]
  def change
    create_table :forecasts do |t|
      t.integer :section_code, default: 0
      t.integer :muni_code, default: 0
      t.integer :state_code, default: 0
      t.integer :district_code, default: 0
      t.string  :election_type
      
      t.integer :forecast_type, default: 0

      t.float :pan, default: 0.0
      t.float :pconv, default: 0.0
      t.float :pes, default: 0.0
      t.float :ph, default: 0.0
      t.float :pmc, default: 0.0
      t.float :pmor, default: 0.0
      t.float :pna, default: 0.0
      t.float :ppm, default: 0.0
      t.float :prd, default: 0.0
      t.float :pri, default: 0.0
      t.float :psd, default: 0.0
      t.float :psm, default: 0.0
      t.float :pt, default: 0.0
      t.float :pvem, default: 0.0

      t.timestamps
    end
  end
end
