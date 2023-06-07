# require_relative './models/patient.rb'
require_relative './models/doctor.rb'
require_relative './models/appointment.rb'
require 'faker'

# Clear existing data
Appointment.destroy_all
Patient.destroy_all
Doctor.destroy_all

# Create patients
5.times do
  Patient.create(
    name: Faker::Name.name,
    age: rand(18..70)
  )
end

# Create doctors
5.times do
  Doctor.create(
    name: Faker::Name.first_name,
    specialty: Faker::Job.title
  )
end

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
  appointment_date: DateTime.now + 2
)

Appointment.create(
  patient_id: Patient.find_by(name: "Jane Smith").id,
  doctor_id: Doctor.find_by(name: additional_doctors[1][:name]).id,
  appointment_date: DateTime.now + 4
)
