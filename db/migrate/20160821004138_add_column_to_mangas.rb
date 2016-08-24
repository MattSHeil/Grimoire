class AddColumnToMangas < ActiveRecord::Migration[5.0]
  def change
  	change_column :mangas, :last_chapter, :decimal
  end
end
