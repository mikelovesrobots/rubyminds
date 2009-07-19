#
# image sizes:
#
#   - full: 300x197
#   - featured: 280x184
#   - small: 140x92
#
class Article < RedisModel
  saved_attributes :title, :blurb, :images, :url

  def self.import
    connection = WWW::Delicious.new(AppConfig.delicious.username, AppConfig.delicious.password)
    connection.posts_all.each do |post|
      unless Article.find(post.uid)
        Article.new(
          :identity => post.uid,
          :title => post.title,
          :url => post.url.to_s,
          :blurb => post.notes
        ).save
        # there's also post.tags => ["tools"]
      end
    end 
  end
 
  def self.last_tweet_identity
    last.first.try(:identity)
  end
end
