class RemoveStatusIdFromBookHistories < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_histories, :status_id, :integer
  end
end
