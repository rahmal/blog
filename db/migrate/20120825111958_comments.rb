class Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :post
      t.string :name
      t.string :email
      t.string :url
      t.string :ip
      t.string :user_agent
      t.boolean :can_post
      t.string :referrer
      t.string :state
      t.text :body:
      t.timestamps
    end
    add_index :comments, :post_id
    add_index :comments, :email
  end
end
