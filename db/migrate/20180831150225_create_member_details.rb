class CreateMemberDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :member_details do |t|
      t.decimal :curr_lat
      t.decimal :curr_long
      
      t.timestamps
    end
  end
end
