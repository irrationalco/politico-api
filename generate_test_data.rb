require 'csv'

supervisors = 4
capturists = 4
capturist_ids = []
@result = CSV.read('test_data.csv', converters: :all, headers: true).by_row!

def create_user(email, suborg, manager, supervisor, capturist)
  t = @result.count
  first_name = @result[rand(t)]['first_name']
  last_name = "#{@result[rand(t)]['first_last_name']} #{@result[rand(t)]['second_last_name']}"
  user = User.new(email: "#{email}@irrational.ly", first_name: first_name,
                  last_name: last_name,
                  password: email, manager: manager,
                  supervisor: supervisor, capturist: capturist, suborganization_id: suborg)
  user.save!
  return user.id
end

(1..supervisors).each do |i|
  create_user "supervisor-#{i}", i, false, true, false
  (1..capturists).each do |j|
    capturist_ids << create_user("capturista-#{i}-#{j}", i, false, false, true)
  end
end

@result.each do |row|
  row = row.to_hash.symbolize_keys
  suborg = rand(1..4)
  capturist = capturist_ids[4 * (suborg - 1) + rand(0..3)]
  row[:suborganization_id] = suborg
  row[:user_id] = capturist
  Voter.create!(row)
end
