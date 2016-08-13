class CreateMangas < ActiveRecord::Migration[5.0]
  def change
    create_table :mangas do |t|
      t.string :title
      t.string :link_to_page
      t.integer :total_chapters
      t.integer :last_chapter
      t.string :posted_date
    	
      t.timestamps
    end
  end
end
