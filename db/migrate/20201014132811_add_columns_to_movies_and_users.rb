class AddColumnsToMoviesAndUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :movies, :user_id, :int
    add_column :users, :admin, :boolean, default: false
  end
end
