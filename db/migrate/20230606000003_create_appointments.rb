class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    # create_table :appointments do |t|
    #   t.string :patient_name
    #   t.references :doctor, foreign_key: true
    #   t.datetime :appointment_date
    #   t.timestamps
    create_table :appointments do |t|
      t.string :patient_name
      t.integer :doctor_id
      t.datetime :appointment_date
      # create_table :appointments do |t|
      #   t.integer :patient_id
      #   t.integer :doctor_id
      #   t.datetime :appointment_date
    end
  
  end
end

