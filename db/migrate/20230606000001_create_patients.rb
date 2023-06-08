class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      # t.string :sex
      # t.integer :age
      # t.string :dob
      # t.string :address
    end
  end
end
