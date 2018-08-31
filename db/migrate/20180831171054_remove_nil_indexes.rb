class RemoveNilIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index "active_books", name: "index_active_books_on_status_id"
  end
end
