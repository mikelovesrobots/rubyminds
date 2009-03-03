class AddBodyCacheFieldtoPostsTable < ActiveRecord::Migration
  def self.up
    add_column :posts, :body_cache, "mediumtext"
  end

  def self.down
    remove_column :posts, :body_cache
  end
end
