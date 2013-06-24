require 'faker'
#No hay necesidad de entender esto, siempre es igual para poblar la BD
#solo hay que tener cuidado configurando los campos
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(nombre: "Juan",
                 email: "juan@torres.com",
                 password: "password",
                 password_confirmation: "password")
    admin.toggle!(:admin)
    1.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@rails.org"
      password  = "password"
      User.create!(nombre: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
