class Article < RedisModel
  saved_attributes :title, :subtitle, :blurb, :body
end
