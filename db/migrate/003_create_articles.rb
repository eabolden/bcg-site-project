class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.column :page_id, :integer
      t.column :article_title, :string
      t.column :article_author, :string
      t.column :article_public_text, :text
      t.column :article_private_text, :text
      t.column :article_weight, :integer
      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
    end
  end

  def self.down
    drop_table :articles
  end
end
