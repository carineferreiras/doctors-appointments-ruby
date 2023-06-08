require 'faker'
require 'active_record'
require 'sqlite3'
require_relative 'app/models/patient'
require_relative 'app/models/doctor'
require_relative 'app/models/appointment'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)
require './db/schema.rb'

# Define your classes and their associations
class Patient < ActiveRecord::Base
  has_many :appointments
end

class Doctor < ActiveRecord::Base
  has_many :appointments
end

class Appointment < ActiveRecord::Base
    belongs_to :patient
    belongs_to :doctor
end
  

# Seed data
5.times do
  Patient.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    sex: Faker::Gender.type,
    age: rand(18..70),
    dob: Faker::Date.birthday(min_age: 18, max_age: 70),
    address: Faker::Address.full_address
  )
end

5.times do
  Doctor.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
  )
end

# CLI interface and application logic
class CLI
  def run
    puts 'Welcome to the Appointment Scheduler!'
    loop do
      puts 'Please select an option:'
      puts '1. Schedule an appointment'
      puts '2. View appointments'
      puts '3. Delete an appointment'
      puts '4. Exit'

      choice = gets.chomp.to_i

      case choice
      when 1
        schedule_appointment
      when 2
        view_appointments
      when 3
        delete_appointment
      when 4
        exit_app
      else
        puts 'Invalid choice. Please try again.'
      end
    end
  end


def schedule_appointment
    puts 'Please enter your name:'
    name = gets.chomp
  
    puts 'Please enter your preferred doctor:'
    doctor_name = gets.chomp
  
    # Check if the doctor already exists
    doctor = Doctor.find_by(first_name: doctor_name)
  
    # If the doctor doesn't exist, create a new one
    unless doctor
      doctor = Doctor.create(first_name: doctor_name)
    end
  
    # Find or create the patient
    patient = Patient.find_or_create_by(first_name: name)
  
    # Create a new appointment
    appointment = Appointment.new(appointment_date: DateTime.now)
    appointment.patient = patient
    appointment.doctor = doctor
    appointment.save
  
    if appointment.valid?
      puts 'Appointment scheduled successfully!'
    else
      puts 'Failed to schedule appointment:'
      puts appointment.errors.full_messages
    end
  
    run
  end
  

  def view_appointments
 puts 'Upcoming Appointments:'
  Appointment.includes(:patient, :doctor).each do |appointment|
    if appointment.patient_id && appointment.doctor_id
      patient = appointment.patient
      doctor = appointment.doctor
      puts "Patient: #{patient.first_name} #{patient.last_name}"
      puts "Doctor: #{doctor.first_name} #{doctor.last_name}"
      puts "Appointment Date: #{appointment.appointment_date}"
      puts '---'
    else
      puts "Incomplete appointment data found. Appointment: #{appointment.inspect}"
    end
  end
run
    end


def delete_appointment
    puts 'Please enter your name:'
    name = gets.chomp
    
    puts 'Please enter the doctor name:'
    doctor_name = gets.chomp
    
    appointment = Appointment.joins(:patient, :doctor)
                            .where('patients.first_name = ? AND doctors.first_name = ?', name, doctor_name)
                            .first
    
    if appointment
      appointment.destroy
      puts 'Appointment deleted successfully!'
    else
      puts 'Appointment not found.'
    end
    
    run
  end
  

  def exit_app
    puts 'Thank you for using the Appointment Scheduler. Goodbye!'
    exit
  end
end

# Run the CLI application
CLI.new.run

