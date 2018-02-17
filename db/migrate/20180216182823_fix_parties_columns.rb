class FixPartiesColumns < ActiveRecord::Migration[5.0]
  def change
    # Projections Table
    rename_column :projections, :PAN, :pan
    rename_column :projections, :PCONV, :pconv
    rename_column :projections, :PES, :pes
    rename_column :projections, :PH, :ph
    rename_column :projections, :PMC, :pmc
    rename_column :projections, :PMOR, :pmor
    rename_column :projections, :PNA, :pna
    rename_column :projections, :PPM, :ppm
    rename_column :projections, :PRD, :prd
    rename_column :projections, :PRI, :pri
    rename_column :projections, :PSD, :psd
    rename_column :projections, :PSM, :psm
    rename_column :projections, :PT, :pt
    rename_column :projections, :PVEM, :pvem

    # State Caches Table
    rename_column :state_caches, :PAN, :pan
    rename_column :state_caches, :PCONV, :pconv
    rename_column :state_caches, :PES, :pes
    rename_column :state_caches, :PH, :ph
    rename_column :state_caches, :PMC, :pmc
    rename_column :state_caches, :PMOR, :pmor
    rename_column :state_caches, :PNA, :pna
    rename_column :state_caches, :PPM, :ppm
    rename_column :state_caches, :PRD, :prd
    rename_column :state_caches, :PRI, :pri
    rename_column :state_caches, :PSD, :psd
    rename_column :state_caches, :PSM, :psm
    rename_column :state_caches, :PT, :pt
    rename_column :state_caches, :PVEM, :pvem
  end
end
