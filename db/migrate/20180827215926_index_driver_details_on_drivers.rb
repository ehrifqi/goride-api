class IndexDriverDetailsOnDrivers < ActiveRecord::Migration[5.2]
  def change
    add_column :driver_details, :driver_id, :integer
    add_index :driver_details, :driver_id
  end
end
