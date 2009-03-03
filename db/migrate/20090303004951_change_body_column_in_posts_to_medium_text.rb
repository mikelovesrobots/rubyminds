class ChangeBodyColumnInPostsToMediumText < ActiveRecord::Migration
  def self.up
    change_column :posts, :body, "mediumtext"
  end

  def self.down
    change_column :posts, :body, :text
  end
end
