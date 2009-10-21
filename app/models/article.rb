#
# image sizes:
#
#   - detailed: 300x197
#   - featured: 280x184
#   - thumb: 140x92
#
# 
class Article < RedisModel
  IMAGES = [:forest_fall, :forest_twilight, :forest_earthy, :leaves_blurry, :forest_path, :trees_lake]

  saved_attributes :title, :blurb, :images, :url, :tags

  def self.import
    connection = WWW::Delicious.new(ENV['RUBYMINDS_DELICIOUS_USERNAME'], ENV['RUBYMINDS_DELICIOUS_PASSWORD'])
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

  # 300x197
  def image_path(type)
    "#{image_base}_#{type}.jpg"
  end

  def image_base
    IMAGES[title.length % IMAGES.length]
  end
end
