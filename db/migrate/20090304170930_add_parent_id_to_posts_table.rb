class AddParentIdToPostsTable < ActiveRecord::Migration
  def self.up
    add_column :posts, :parent_id, :integer, :references => [:posts, :id]
    add_index :posts, [:parent_id, :created_at]
  end

  def self.down
    remove_column :posts, :parent_id
  end
end
