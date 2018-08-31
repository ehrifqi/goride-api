class IndexOrderStatusOnBookingTables < ActiveRecord::Migration[5.2]
  def change
    add_index :active_books, :order_status_id
    add_index :book_histories, :order_status_id
  end
end
