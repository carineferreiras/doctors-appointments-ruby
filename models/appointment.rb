require 'active_record'

class Appointment < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor
end
