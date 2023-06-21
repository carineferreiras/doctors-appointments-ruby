class Appointment < ActiveRecord::Base 

    belongs_to :patient
    belongs_to :doctor
    attribute :name, :string
end