class CreateActiveBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :active_books do |t|
      t.integer :member_id
      t.integer :driver_id
      t.integer :status_id
      t.decimal :src_lat
      t.decimal :src_long
      t.decimal :dest_lat
      t.decimal :dest_long
      t.integer :price
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
