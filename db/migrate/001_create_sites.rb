class CreateSites < ActiveRecord::Migration
  def self.up
    create_table :sites do |t|
      t.column :contact, :string
      t.column :sitename, :string
      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
    end
  end

  def self.down
    drop_table :sites
  end
end
