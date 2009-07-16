class Article < RedisModel
  def title
    attributes["title"]
  end

  def title=(value)
    attributes["title"] = value
  end
  
  def blurb
    attributes["blurb"]
  end

  def blurb=(value)
    attributes["blurb"] = value
  end

  def body
    attributes["body"]
  end

  def body=(value)
    attributes["body"] = value
  end
end
