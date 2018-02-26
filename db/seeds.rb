require 'csv'

########################################
# Demographics Dummy Data for Nuevo Leon
# Municipalities
# puts 'Creating states and municipalities...'
# t = Time.now

# ActiveRecord::Base.logger.silence do
#   for i in 0..55
#     for j in 0..3000
#       Demographic.create(section_code: j, muni_code: i, state_code: 19, district_code: nil,
#                          total: Random.rand(5000), year: 2015, hombres: Random.rand(0.0...100.0).round(2),
#                          mujeres: Random.rand(0.0...100.0).round(2), hijos: Random.rand(0.5...4).round(2),
#                          entidad_nac: Random.rand(0.0...100.0).round(2),
#                          entidad_inm: Random.rand(0.0...100.0).round(2),
#                          limitacion: Random.rand(0.0...100.0).round(2),
#                          analfabetismo: Random.rand(0.0...100.0).round(2),
#                          educacion_av: Random.rand(0.0...100.0).round(2),
#                          pea: Random.rand(0.0...100.0).round(2),
#                          no_serv_salud: Random.rand(0.0...100.0).round(2),
#                          matrimonios: Random.rand(0.0...100.0).round(2),
#                          hogares: Random.rand(0.0...100.0).round(2),
#                          hogares_jefa: Random.rand(0.0...100.0).round(2),
#                          hogares_pob: Random.rand(0.0...100.0).round(2),
#                          auto: Random.rand(0.0...100.0).round(2),
#                          entidad_mig: Random.rand(0.0...100.0).round(2))
#     end
#   end

#   # Districts
#   for x in 0..20
#     for y in 0..3000
#       Demographic.create(section_code: y, muni_code: nil, state_code: 19, district_code: x,
#                          total: Random.rand(5000), year: 2015, hombres: Random.rand(0.0...100.0).round(2),
#                          mujeres: Random.rand(0.0...100.0).round(2), hijos: Random.rand(0.5...4).round(2),
#                          entidad_nac: Random.rand(0.0...100.0).round(2),
#                          entidad_inm: Random.rand(0.0...100.0).round(2),
#                          limitacion: Random.rand(0.0...100.0).round(2),
#                          analfabetismo: Random.rand(0.0...100.0).round(2),
#                          educacion_av: Random.rand(0.0...100.0).round(2),
#                          pea: Random.rand(0.0...100.0).round(2),
#                          no_serv_salud: Random.rand(0.0...100.0).round(2),
#                          matrimonios: Random.rand(0.0...100.0).round(2),
#                          hogares: Random.rand(0.0...100.0).round(2),
#                          hogares_jefa: Random.rand(0.0...100.0).round(2),
#                          hogares_pob: Random.rand(0.0...100.0).round(2),
#                          auto: Random.rand(0.0...100.0).round(2),
#                          entidad_mig: Random.rand(0.0...100.0).round(2))
#     end
#   end
# end

# puts "Done Demographics: #{Time.now - t}s"

##############################
# Creando estados y municipios
# puts 'Creating states and municipalities...'
# t = Time.now

# ActiveRecord::Base.logger.silence do
#   muni_ids = CSV.read('tbl_ids.csv')
#   muni_ids.shift

#   muni_ids.each do |row|
#     row[1] = 'Veracruz de Ignacio de la Llave' if row[1] == 'Veracruz'
#     row[1] = 'Michoacán de Ocampo' if row[1] == 'Michoacán'
#     row[1] = 'Michoacán de Ocampo' if row[1] == 'Michoacán'
#     row[1] = 'Coahuila de Zaragoza' if row[1] == 'Coahuila'

#     state = State.find_or_create_by(name: row[1]) do |a_state|
#       a_state.state_code = row[0]
#     end

#     muni = Municipality.where(name: row[3]).take
#     muni = if muni.nil?
#              Municipality.create(name: row[3], muni_code: row[2], state_code: row[0])
#            elsif muni.state_code != state.state_code
#              Municipality.create(name: row[3], muni_code: row[2], state_code: row[0])
#            end

#     state.municipalities << muni unless muni.nil? && state.municipalities.exists?(id: muni.id)
#   end
# end

# puts "Done munis: #{Time.now - t}s"

######################################
# Cargando datos historicos del INE
# puts 'Creating projections...'
# t = Time.now

# ActiveRecord::Base.logger.silence do
#   ine_data = CSV.read('tbl_ine.csv')
#   ine_data.shift

#   ine_data.each do |row|
#     year          = row[0].to_i
#     election_type = row[1]
#     state_code    = row[2].to_i
#     muni_code     = row[4] .to_i
#     district_code = row[6].to_i
#     section_code  = row[7].to_i
#     nominal_list  = row[8].to_i

#     pan    = row[9].to_i
#     pconv  = row[10].to_i
#     pes  = row[12].to_i
#     ph   = row[13].to_i
#     pmc  = row[14].to_i
#     pmor = row[15].to_i
#     pna  = row[16].to_i
#     ppm  = row[17].to_i
#     prd  = row[18].to_i
#     pri  = row[19].to_i
#     psd  = row[20].to_i
#     psm  = row[21].to_i
#     pt   = row[23].to_i
#     pvem = row[24].to_i

#     total = pan + pconv + pes + ph + pmc + pmor + pna + ppm + prd + pri + psd + psm + pt + pvem

#     Projection.create(state_code: state_code, muni_code: muni_code, section_code: section_code,
#                       district_code: district_code, nominal_list: nominal_list,
#                       year: year, election_type: election_type,
#                       pan: pan, pconv: pconv, pes: pes, ph: ph, pmc: pmc, pmor: pmor, pna: pna, ppm: ppm, prd: prd,
#                       pri: pri, psd: psd, psm: psm, pt: pt, pvem: pvem, total_votes: total)
#   end
# end

# puts "Done projections: #{Time.now - t}s"

# # ############################################################################################
# # Creando cache de datos por estado
# puts 'Creating states chache...'
# t = Time.now

# ActiveRecord::Base.logger.silence do
#   state_data = Projection.select('SUM("pan") as "pan", SUM("pconv") as "pconv", SUM("pes") as "pes",
#                                   SUM("ph") as "ph", SUM("pmc") as "pmc", SUM("pmor") as "pmor", SUM("pna") as "pna",
#                                   SUM("ppm") as "ppm", SUM("prd") as "prd", SUM("pri") as "pri", SUM("psd") as "psd",
#                                   SUM("psm") as "psm", SUM("pt") as "pt", SUM("pvem") as "pvem", SUM("total_votes") as
#                                   "total_votes", state_code, year, election_type')
#                          .group(:state_code, :year, :election_type)

#   state_data.each do |data|
#     StateCache.create(state_code: data.state_code, year: data.year, election_type: data.election_type,
#                       pan: data.pan, pconv: data.pconv, pes: data.pes, ph: data.ph, pmc: data.pmc,
#                       pmor: data.pmor, pna: data.pna, ppm: data.ppm, prd: data.prd, pri: data.pri,
#                       psd: data.psd, psm: data.psm, pt: data.pt, pvem: data.pvem, total_votes: data.total_votes)
#   end
# end

# puts "Done states cache: #{Time.now - t}s"

##########################################################################################################
# tbl_ine.csv SCHEMA
#  0      1          2          3          4            5          6            7       8
# ANO, Eleccion, Id_entidad, Entidad, Id_municipio, Municipio, id_distrito, seccion, nominal,
#
#  9    10      11    12   13  14    15   16   17   18   19   20   21   22   23   24
# pan, pconv, PDSPPN, pes, ph, pmc, pmor, pna, ppm, prd, pri, psd, psm, PSN, pt, pvem
###########################################################################################################

# Creando Voters
# puts "Creating voters..."
# t = Time.now
# ine_data = CSV.read("tbl_voters_chica.csv")
# ine_data.shift

# ine_data.each do |row|
#   electoral_code = row[0]
#   name = row[1]
#   first_last_name = row[2]
#   second_last_name = row[3]
#   date_of_birth = Date.parse(row[4])
#   street = row[5]
#   outside_number = row[6]
#   inside_number = row[7]
#   suburb = row[8]
#   postal_code = row[9].to_i
#   TIMERES = row[10].to_i
#   occupation = row[11]
#   FOL_NAC = row[12].to_i
#   EN_LN = row[13].to_i == 1
#   municipality_name = row[14]
#   state = row[15].to_i
#   district = row[16].to_i
#   municipality = row[17].to_i
#   section = row[18].to_i
#   locality = row[19].to_i
#   apple = row[20].to_i
#   CONS_LC = row[21].to_i
#   EMISIONCRE = row[22].to_i
#   Voter.create(electoral_code: electoral_code, name: name, first_last_name: first_last_name,
#               second_last_name: second_last_name, date_of_birth: date_of_birth, street: street,
#               outside_number: outside_number, inside_number: inside_number, suburb: suburb,
#               postal_code: postal_code, TIMERES: TIMERES, occupation: occupation, FOL_NAC: FOL_NAC,
#               EN_LN: EN_LN, municipality_name: municipality_name, state: state, district: district,
#               municipality: municipality, section: section, locality: locality, apple: apple,
#               CONS_LC: CONS_LC, EMISIONCRE: EMISIONCRE)
# end

# puts "Done voters: #{Time.now - t}s"

unless Rails.env == 'production'
  puts "\nAvailable Users:\n"
  puts 'Manager: manager@irrational.ly Pass: manager'
  puts 'Capturist: capturist@irrational.ly Pass: capturist'
  puts 'Supervisor: supervisor@irrational.ly Pass: supervisor'
  puts 'Superadmin: superadmin@irrational.ly Pass: superadmin'
  User.create(email: 'manager@irrational.ly', password: 'manager', manager: true)
  User.create(email: 'capturist@irrational.ly', password: 'capturist', capturist: true)
  User.create(email: 'supervisor@irrational.ly', password: 'supervisor', supervisor: true)
  User.create(email: 'superadmin@irrational.ly', password: 'superadmin', superadmin: true)
end

forecast_seeder = CSV.read('forecast_seeder.csv')
forecast_seeder.shift

forecast_seeder.each do |row|
  forecast_type = row[0].to_i
  state = row[1]
  district    = row[2].to_i
  section     = row[3] .to_i
  muni = row[4].to_i

  pan    = row[5].to_f
  pconv  = row[6].to_f
  pes  = row[7].to_f
  ph   = row[8].to_f
  pmc  = row[9].to_f
  pmor = row[10].to_f
  pna  = row[11].to_f
  ppm  = row[12].to_f
  prd  = row[13].to_f
  pri  = row[14].to_f
  psd  = row[15].to_f
  psm  = row[16].to_f
  pt   = row[17].to_f
  pvem = row[18].to_f

  Forecast.create forecast_type: forecast_type,
                  state_code: state,
                  muni_code: muni,
                  district_code: district,
                  section_code: section,
                  pan: pan,
                  pconv: pconv,
                  pes: pes,
                  ph: ph,
                  pmc: pmc,
                  pmor: pmor,
                  pna: pna,
                  ppm: ppm,
                  prd: prd,
                  pri: pri,
                  psd: psd,
                  psm: psm,
                  pt: pt,
                  pvem: pvem
end
