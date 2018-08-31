class IndexIdsOnBookHistories < ActiveRecord::Migration[5.2]
  def change
  	add_index :book_histories, :member_id
  	add_index :book_histories, :driver_id
  end
end
