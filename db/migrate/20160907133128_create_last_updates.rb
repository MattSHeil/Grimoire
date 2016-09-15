class CreateLastUpdates < ActiveRecord::Migration[5.0]
  def change
    create_table :last_updates do |t|
      t.string :title
      t.string :link_to_page
      t.string :date

      t.timestamps
    end
  end
end
