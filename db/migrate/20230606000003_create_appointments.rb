class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
  
    create_table :appointments do |t|
      t.string :patient_name
      t.integer :doctor_id
      t.datetime :appointment_date
     

    end
  
  end
end

