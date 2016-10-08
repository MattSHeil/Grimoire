class CreateMangaImgs < ActiveRecord::Migration[5.0]
  def change
    create_table :manga_imgs do |t|
      t.references :manga, index: true, foreign_key: true
      t.string :cover_img_url

      t.timestamps
    end
  end
end
