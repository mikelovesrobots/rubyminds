class RemovePublishedColumnFromPostsTable < ActiveRecord::Migration
  def self.up
    remove_column :posts, :published
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
