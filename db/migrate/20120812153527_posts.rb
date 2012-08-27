class Posts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.string :title
      t.string :state
      t.datetime :published_at
      t.string :permalink 
      t.text :body
      t.timestamps
    end
    add_index :posts, :author_id
    add_index :posts, :permalink
  end
end
