puts "🌱 SEEDING DATA....."

#Faker Code
require 'faker'
require 'active_record'
require_relative '../app/models/patient'
require_relative '../app/models/doctor'
require_relative '../app/models/appointment'

# Establish database connection
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)
require_relative '../db/schema'



# puts "🌱 SEEDING DATA....."
Appointment.delete_all
Doctor.delete_all
Patient.delete_all


  # 2.times do
  # doctor= Doctor.create(
   
  #   full_name : full_name,
  #    )

  #    5.times do
  #        patient= Patient.create(
  #            first_name: Faker::Name.first_name,
  #            last_name: Faker::Name.last_name,
  #               )


  #        appointment = Appointment.create(
  #         patient_id:first_name,
  #         doctor_id: full_name, 
  #         appointment_date: appointment_date,
        
        
  #         appointment_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30),
  #      patient_id: name,
  #      doctor_id: Doctor,
  #        )

  #    end 

  
  2.times do
    doctor = Doctor.create(
      full_name: Faker::Name.name
    )
  
    5.times do
      patient = Patient.create(
        first_name: Faker::Name.first_name
      )
  
      appointment = Appointment.create(
        patient_id: patient.id,
        doctor_id: doctor.id,
        appointment_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30)
      )
    end
  end

puts "🌱 DONE SEEDING!!!!"


