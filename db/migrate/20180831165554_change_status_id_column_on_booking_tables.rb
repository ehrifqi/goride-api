class ChangeStatusIdColumnOnBookingTables < ActiveRecord::Migration[5.2]
  def change
    remove_column :active_books, :status_id
    add_column :active_books, :order_status_id, :integer

    remove_column :book_histories, :status_id
    add_column :book_histories, :order_status_id, :integer
  end
end
