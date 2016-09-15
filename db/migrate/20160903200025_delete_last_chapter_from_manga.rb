class DeleteLastChapterFromManga < ActiveRecord::Migration[5.0]
  def change
  	remove_column :mangas, :last_chapter 
  end
end
