require 'nokogiri'
require 'open-uri'
require 'active_record'
require 'faker'
require_relative './models/patient.rb'
require_relative './models/doctor.rb'
require_relative './models/appointment.rb'
require_relative 'scraper'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'appointments.db'
)

# CLI interface and application logic
class CLI
  def initialize
    @scraper = Scraper.new('https://example.com')
    @scraper.scrape_data
  end

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
    doctor = Doctor.find_by(name: doctor_name)

    # If the doctor doesn't exist, create a new one
    unless doctor
      doctor = Doctor.create(name: doctor_name)
    end

    # Create a new patient and appointment
    patient = Patient.create(name: name)
    appointment = Appointment.create(patient: patient, doctor: doctor, appointment_date: DateTime.now)

    puts 'Appointment scheduled successfully!'

    run
  end

  def view_appointments
    puts 'Upcoming Appointments:'
    Appointment.all.each do |appointment|
      puts "Patient: #{appointment.patient.name}"
      puts "Doctor: #{appointment.doctor.name}"
      puts "Appointment Date: #{appointment.appointment_date}"
      puts '---'
    end

    run
  end

  def delete_appointment
    puts 'Please enter your name:'
    name = gets.chomp

    puts 'Please enter the doctor name:'
    doctor_name = gets.chomp

    appointment = Appointment.find_by(patient: { name: name }, doctor: { name: doctor_name })

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
