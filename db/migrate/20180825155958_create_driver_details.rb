class CreateDriverDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :driver_details do |t|
      t.decimal :curr_lat
      t.decimal :curr_long
      t.boolean :is_active

      t.timestamps
    end
  end
end
