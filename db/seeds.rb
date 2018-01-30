require 'csv'
puts "################\nSeeds"

# Demographics Dummy Data for Nuevo Leon
# Municipalities
for i in 0..55
  for j in 0..3000
    Demographic.create(section_code: j, muni_code: i, state_code: 19, district_code: nil,
                       total: Random.rand(5000), year: 2015, hombres: Random.rand(0.0...100.0).round(2),
                       mujeres: Random.rand(0.0...100.0).round(2), hijos: Random.rand(0.5...4).round(2),
                       entidad_nac: Random.rand(0.0...100.0).round(2), entidad_inm: Random.rand(0.0...100.0).round(2),
                       limitacion: Random.rand(0.0...100.0).round(2), analfabetismo: Random.rand(0.0...100.0).round(2),
                       educacion_av: Random.rand(0.0...100.0).round(2), pea: Random.rand(0.0...100.0).round(2),
                       no_serv_salud: Random.rand(0.0...100.0).round(2), matrimonios: Random.rand(0.0...100.0).round(2),
                       hogares: Random.rand(0.0...100.0).round(2), hogares_jefa: Random.rand(0.0...100.0).round(2),
                       hogares_pob: Random.rand(0.0...100.0).round(2), auto:  Random.rand(0.0...100.0).round(2),
                       entidad_mig: Random.rand(0.0...100.0).round(2))
  end
end

# Districts
for x in 0..20
  for y in 0..3000
    Demographic.create(section_code: y, muni_code: nil, state_code: 19, district_code: x,
                       total: Random.rand(5000), year: 2015, hombres: Random.rand(0.0...100.0).round(2),
                       mujeres: Random.rand(0.0...100.0).round(2), hijos: Random.rand(0.5...4).round(2),
                       entidad_nac: Random.rand(0.0...100.0).round(2), entidad_inm: Random.rand(0.0...100.0).round(2),
                       limitacion: Random.rand(0.0...100.0).round(2), analfabetismo: Random.rand(0.0...100.0).round(2),
                       educacion_av: Random.rand(0.0...100.0).round(2), pea: Random.rand(0.0...100.0).round(2),
                       no_serv_salud: Random.rand(0.0...100.0).round(2), matrimonios: Random.rand(0.0...100.0).round(2),
                       hogares: Random.rand(0.0...100.0).round(2), hogares_jefa: Random.rand(0.0...100.0).round(2),
                       hogares_pob: Random.rand(0.0...100.0).round(2), auto:  Random.rand(0.0...100.0).round(2),
                       entidad_mig: Random.rand(0.0...100.0).round(2))
  end
end

# def delete_dbs(*class_names)
#   class_names.each do |cname|
#     puts "Deleting from table `#{cname}`."
#     cname.send(:delete_all)
#   end
# end

# delete_dbs(State, Municipality,Projection,Poll,Section)

##############################
# Creando estados y municipios
puts 'Creating states and municipalities...'
t = Time.now

muni_ids = CSV.read('tbl_ids.csv')
muni_ids.shift

muni_ids.each do |row|
  row[1] = 'Veracruz de Ignacio de la Llave' if row[1] == 'Veracruz'
  row[1] = 'Michoacán de Ocampo' if row[1] == 'Michoacán'
  row[1] = 'Michoacán de Ocampo' if row[1] == 'Michoacán'
  row[1] = 'Coahuila de Zaragoza' if row[1] == 'Coahuila'

  state = State.find_or_create_by(name: row[1]) do |a_state|
    a_state.state_code = row[0]
  end

  muni = Municipality.where(name: row[3]).take
  muni = if muni.nil?
           Municipality.create(name: row[3], muni_code: row[2], state_code: row[0])
         elsif muni.state_code != state.state_code
           Municipality.create(name: row[3], muni_code: row[2], state_code: row[0])
         end

  state.municipalities << muni unless muni.nil? && state.municipalities.exists?(id: muni.id)
end

puts "Done munis: #{Time.now - t}s"

# tbl_ids.csv schema
#     0            1          2            3
# codigo_edo, nombre_edo, codigo_muni, nombre_muni
#####################################################

##################################
# Cargando datos historicos del INE
puts 'Creating projections...'
t = Time.now

ine_data = CSV.read('tbl_ine.csv') # tbl_ine_chica.csv / tbl_ine.csv
ine_data.shift

ine_data.each do |row|
  year          = row[0].to_i
  election_type = row[1]
  state_code    = row[2].to_i
  muni_code     = row[4] .to_i
  district_code = row[6].to_i
  section_code  = row[7].to_i
  nominal_list  = row[8].to_i

  pan    = row[9].to_i
  pconv  = row[10].to_i
  pes  = row[12].to_i
  ph   = row[13].to_i
  pmc  = row[14].to_i
  pmor = row[15].to_i
  pna  = row[16].to_i
  ppm  = row[17].to_i
  prd  = row[18].to_i
  pri  = row[19].to_i
  psd  = row[20].to_i
  psm  = row[21].to_i
  pt   = row[23].to_i
  pvem = row[24].to_i

  total = pan + pconv + pes + ph + pmc + pmor + pna + ppm + prd + pri + psd + psm + pt + pvem

  Projection.create(state_code: state_code, muni_code: muni_code, section_code: section_code,
                    district_code: district_code, nominal_list: nominal_list, year: year, election_type: election_type,
                    PAN: pan, PCONV: pconv, PES: pes, PH: ph, PMC: pmc, PMOR: pmor, PNA: pna, PPM: ppm, PRD: prd,
                    PRI: pri, PSD: psd, PSM: psm, PT: pt, PVEM: pvem, total_votes: total)
end

puts "Done projections: #{Time.now - t}s"

# ############################################################################################
# Creando cache de datos por estado
# puts "Creating states chache..."
# t = Time.now
#
# state_data = Projection.select('SUM("PAN") as "PAN", SUM("PCONV") as "PCONV", SUM("PES") as "PES",
#                                 SUM("PH") as "PH", SUM("PMC") as "PMC", SUM("PMOR") as "PMOR", SUM("PNA") as "PNA",
#                                 SUM("PPM") as "PPM", SUM("PRD") as "PRD", SUM("PRI") as "PRI", SUM("PSD") as "PSD",
#                                 SUM("PSM") as "PSM", SUM("PT") as "PT", SUM("PVEM") as "PVEM", SUM("total_votes") as
#                                 "total_votes", state_code, year, election_type')
#                        .group(:state_code,:year,:election_type)
#
# state_data.each do |data|
#   StateCache.create(state_code: data.state_code, year: data.year, election_type: data.election_type,
#                     PAN: data.PAN, PCONV: data.PCONV, PES: data.PES, PH: data.PH, PMC: data.PMC,
#                     PMOR: data.PMOR, PNA: data.PNA, PPM: data.PPM, PRD: data.PRD, PRI: data.PRI,
#                     PSD: data.PSD, PSM: data.PSM, PT: data.PT, PVEM: data.PVEM, total_votes: data.total_votes)
# end
#
# puts "Done states cache: #{Time.now - t}s"

##########################################################################################################
# tbl_ine.csv SCHEMA
#  0      1          2          3          4            5          6            7       8
# ANO, Eleccion, Id_entidad, Entidad, Id_municipio, Municipio, id_distrito, seccion, nominal,
#
#  9    10      11    12   13  14    15   16   17   18   19   20   21   22   23   24
# PAN, PCONV, PDSPPN, PES, PH, PMC, PMOR, PNA, PPM, PRD, PRI, PSD, PSM, PSN, PT, PVEM
###########################################################################################################

# Creando algunos polls y sections de prueba para las encuestas
poll = Poll.create(name: 'Primer Encuesta', total_sections: 5)
Poll.create(name: 'Segunda Encuesta', total_sections: 4)

Section.create(title: '¿Cómo te sientes sobre...?', poll: poll)
Section.create(title: '¿Si hoy tuvieras que votar por el presidente, qué tan probable sería que eligieras a...?',
               poll: poll)
Section.create(title: '¿Si hoy tuvieras que votar por Alcalde de Monterrey, qué tan probable sería que eligieras a...?',
               poll: poll)
Section.create(title: '¿Cómo crees que sea su caracter como persona?', poll: poll)
Section.create(title: 'Un poco sobre ti: ', poll: poll)

puts 'Done polls'

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
