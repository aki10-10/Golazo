class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :blog, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
    
  end  
end
