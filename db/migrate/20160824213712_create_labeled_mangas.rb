class CreateLabeledMangas < ActiveRecord::Migration[5.0]
  def change
    create_table :labeled_mangas do |t|
      t.references :manga, index: true, foreign_key: true
      t.references :label, index: true, foreign_key: true

      t.timestamps
    end
  end
end
