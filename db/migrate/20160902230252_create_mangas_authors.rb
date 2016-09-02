class CreateMangasAuthors < ActiveRecord::Migration[5.0]
  def change
    create_table :mangas_authors do |t|
      t.references :manga_id, index: true, foreign_key: true
      t.references :author_id, index: true, foreign_key: true

      t.timestamps
    end
  end
end
