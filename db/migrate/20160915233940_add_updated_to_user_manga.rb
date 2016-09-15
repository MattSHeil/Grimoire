class AddUpdatedToUserManga < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_mangas, :updated, :boolean, default: false
  end
end
