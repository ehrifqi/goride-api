class IndexIdsOnActiveBooks < ActiveRecord::Migration[5.2]
  def change
  	add_index :active_books, :member_id
  	add_index :active_books, :driver_id
  	add_index :active_books, :status_id
  end
end
