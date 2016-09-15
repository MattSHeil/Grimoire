class DeleteDateFromLastUpdate < ActiveRecord::Migration[5.0]
  def change
  	remove_column :last_updates, :date 
  end
end
