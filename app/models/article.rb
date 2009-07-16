#
# image sizes:
#
#   - full: 300x197
#   - featured: 280x184
#   - small: 140x92
#
class Article < RedisModel
  saved_attributes :title, :subtitle, :blurb, :body, :images
end
