class ChangeStatusIdColumnOnBookingTables < ActiveRecord::Migration[5.2]
  def change
    if column_exists? :active_books, :status_id
      remove_column :active_books, :status_id
    end
    add_column :active_books, :order_status_id, :integer

    if column_exists? :book_histories, :status_id
      remove_column :book_histories, :status_id
    end
    add_column :book_histories, :order_status_id, :integer
  end
end
