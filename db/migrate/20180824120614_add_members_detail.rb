class AddMembersDetail < ActiveRecord::Migration[5.2]
  def change
  	add_column :members, :phone_number, :integer
  	add_column :members, :go_pay_value, :integer
  	add_column :members, :go_point_value, :integer
  end
end
