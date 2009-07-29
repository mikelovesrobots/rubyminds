#
# image sizes:
#
#   - full: 300x197
#   - featured: 280x184
#   - small: 140x92
#
# 
class Article < RedisModel
  saved_attributes :title, :blurb, :images, :url, :tags

  def self.import
    connection = WWW::Delicious.new(AppConfig.delicious.username, AppConfig.delicious.password)
    connection.posts_all.reverse.each do |post|
      unless Article.find(post.uid)
        Article.new(
          :identity => post.uid,
          :title => post.title,
          :url => post.url.to_s,
          :blurb => post.notes,
          :tags => post.tags
        ).save
      end
    end 
  end
end
