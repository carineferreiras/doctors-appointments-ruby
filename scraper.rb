require 'nokogiri'
require 'open-uri'
require 'faker'
require_relative './models/doctor.rb'
require_relative './models/patient.rb'
require_relative './models/appointment.rb'

class Scraper
  def initialize(url)
    @url = url
  end

  def scrape_data
    html = URI.open(@url)
    doc = Nokogiri::HTML(html)

    doc.css('.doctor-card').each do |card|
      name = card.css('.name').text.strip
      specialty = card.css('.specialty').text.strip

      doctor = Doctor.find_or_create_by(name: name, specialty: specialty)

      5.times do
        patient_name = Faker::Name.name
        appointment_time = Faker::Time.between_dates(from: Date.today, to: Date.today + 30, period: :day)

        patient = Patient.find_or_create_by(name: patient_name)

        Appointment.create(doctor: doctor, patient: patient, appointment_time: appointment_time)
      end
    end
  end
end
