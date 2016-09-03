class CreateMangasArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :mangas_artists do |t|
      t.references :manga, index: true, foreign_key: true
      t.references :artist, index: true, foreign_key: true

      t.timestamps
    end
  end
end
