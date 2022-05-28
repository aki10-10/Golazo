class CreateBlogTags < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_tags do |t|
      t.references :blog, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようになる
    add_index :blog_tags, [:blog_id, :tag_id], unique: true
  end
end
