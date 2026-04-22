class AddUrlToFavorites < ActiveRecord::Migration[8.1]
  def change
    add_column :favorites, :url, :string
  end
end
