class AddFullNameToDoctors < ActiveRecord::Migration[6.1]
  def change
    add_column :doctors, :full_name, :string
  end
end
