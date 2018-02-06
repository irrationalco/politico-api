namespace :users do
  desc 'Create demo users'
  task create_demo_users: :environment do
    puts 'Available Users:\n'
    puts 'Manager: manager@irrational.ly Pass: manager'
    puts 'Capturist: capturist@irrational.ly Pass: capturist'
    puts 'Supervisor: supervisor@irrational.ly Pass: supervisor'
    puts 'Superadmin: superadmin@irrational.ly Pass: superadmin'
    User.create(email: 'manager@irrational.ly', password: 'manager', manager: true)
    User.create(email: 'capturist@irrational.ly', password: 'capturist', capturist: true)
    User.create(email: 'supervisor@irrational.ly', password: 'supervisor', supervisor: true)
    User.create(email: 'superadmin@irrational.ly', password: 'superadmin', superadmin: true)
  end
end
