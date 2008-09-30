class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.column :site_id, :integer
      t.column :page_title, :string
      t.column :page_author, :string
      t.column :page_about, :string
      t.column :page_weight, :integer
      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
    end
  end

  def self.down
    drop_table :pages
  end
end
