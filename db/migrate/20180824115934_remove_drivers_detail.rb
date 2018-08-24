class RemoveDriversDetail < ActiveRecord::Migration[5.2]
  def change
  	remove_column :drivers, :age, :integer
  end
end
