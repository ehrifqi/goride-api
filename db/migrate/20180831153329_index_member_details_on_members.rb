class IndexMemberDetailsOnMembers < ActiveRecord::Migration[5.2]
  def change
  	add_column :member_details, :member_id, :integer
    add_index :member_details, :member_id
  end
end
