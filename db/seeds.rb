puts "🌱 SEEDING DATA....."

#Faker Code
require 'faker'
require 'active_record'
require_relative 'app/models/patient'
require_relative 'app/models/doctor'
require_relative 'app/models/appointment'

# Establish database connection
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)
require_relative 'db/schema'

# Define your classes and their associations
class Patient < ActiveRecord::Base
  has_many :appointments
  has_many :doctors, through: :appointments

  validates :first_name, presence: true
  validates :last_name, presence: true
end

class Doctor < ActiveRecord::Base
  has_many :appointments
  has_many :patients, through: :appointments
end

class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor
  attribute :appointment_date, :datetime
end

# Seed data
5.times do
  Patient.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    
  )
end

5.times do
  Doctor.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
  )
end

puts 'Seed data has been created successfully!'

# Additional patients
additional_patients = [
  { name: "John Doe", age: 35 },
  { name: "Jane Smith", age: 42 }
]

additional_patients.each do |patient|
  Patient.create(patient)
end

# Additional doctors
additional_doctors = [
  { name: "Dr. #{Faker::Name.last_name}", specialty: Faker::Job.title },
  { name: "Dr. #{Faker::Name.last_name}", specialty: Faker::Job.title }
]

additional_doctors.each do |doctor|
  Doctor.create(doctor)
end

# Additional appointments
Appointment.create(
  patient_id: Patient.find_by(name: "John Doe").id,
  doctor_id: Doctor.find_by(name: additional_doctors[0][:name]).id,
  
)

Appointment.create(
  patient_id: Patient.find_by(name: "Jane Smith").id,
  doctor_id: Doctor.find_by(name: additional_doctors[1][:name]).id,
  
)


puts "🌱 DONE SEEDING!!!!"


