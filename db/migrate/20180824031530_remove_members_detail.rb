class RemoveMembersDetail < ActiveRecord::Migration[5.2]
  def change
    remove_column :members, :username, :string
    remove_column :members, :age, :integer
    remove_column :members, :birthdate, :datetime
  end
end
