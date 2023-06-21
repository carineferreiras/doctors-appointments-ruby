require 'active_record'
require_relative './config/environment'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)

# CLI 
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
  
    display_doctors
  
    puts 'Please choose a doctor (enter the number):'
    doctor_choice = gets.chomp.to_i
  
    doctor = case doctor_choice
             when 1 then Doctor.find_by(full_name: 'Donette Kunde')
             when 2 then Doctor.find_by(full_name: 'Pres. Lynn Beer')
             else
               puts 'Invalid doctor selection.'
               return
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
  




def display_doctors
  puts 'Available Doctors:'
  Doctor.pluck(:full_name).each_with_index do |name, index|
    puts "#{index + 1}. #{name}"
  end
end



def view_appointments
  puts 'Upcoming Appointments:'
  Appointment.includes(:doctor, :patient).each do |appointment|
    if appointment.patient && appointment.doctor && appointment.valid?
      puts "Appointment: ID: #{appointment.id}, Patient: #{appointment.patient.first_name}, Doctor: #{appointment.doctor.full_name}, Date: #{appointment.appointment_date}"
      puts '---'
    else
      puts 'No appointment found.'
    end
  end
  run
end





def delete_appointment
  puts 'Please enter your name:'
  name = gets.chomp

  patient = Patient.find_by(first_name: name)
  if patient.nil?
    puts 'Patient not found.'
    return
  end

  appointments = Appointment.joins(:patient, :doctor)
                            .where('patients.first_name = ?', name)

  if appointments.empty?
    puts 'No appointments found for the patient.'
    return
  end

  puts 'Appointments:'
  appointments.each do |appointment|
    puts "ID: #{appointment.id}, Patient: #{appointment.patient.first_name}, Doctor: #{appointment.doctor.full_name}, Date: #{appointment.appointment_date}"
  end

  puts 'Please enter the ID of the appointment to delete:'
  appointment_id = gets.chomp.to_i

  appointment = Appointment.find_by(id: appointment_id)
  if appointment.nil?
    puts 'Invalid appointment ID.'
    return
  end

  appointment.destroy
  puts 'Appointment deleted successfully!'

  run
end




def exit_app
  puts 'Thank you for using the Appointment Scheduler. Goodbye!'
  exit
end
end

# Run the CLI application
CLI.new.run