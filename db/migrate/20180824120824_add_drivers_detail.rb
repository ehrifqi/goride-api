class AddDriversDetail < ActiveRecord::Migration[5.2]
  def change
  	add_column :drivers, :phone_number, :integer
  	add_column :drivers, :license_number, :integer
  	add_column :drivers, :ktp_number, :integer
  	add_column :drivers, :address, :string
  	add_column :drivers, :income, :integer
  end
end
