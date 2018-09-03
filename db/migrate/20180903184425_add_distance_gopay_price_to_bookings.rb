class AddDistanceGopayPriceToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :active_books, :price_with_gopay, :integer
    add_column :active_books, :distance, :decimal
    add_column :book_histories, :price_with_gopay, :integer
    add_column :book_histories, :distance, :decimal
  end
end
