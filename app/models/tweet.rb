class Tweet < RedisModel
  def text
    attributes['text']
  end

  def text=(value)
    attributes['text'] = value
  end

  def self.import
    search = Twitter::Search.new.from('mikelovesrobots').since(last_tweet_id)
    search.each do |result| 
      attributes = {
        'identity' => result["id"],
        'text'       => result["text"],
        'created_at' => result["created_at"]
      }

      Tweet.new(attributes).save
    end
  end

  # Returns the most recent Twitter tweet id in the database
  #
  #   Tweet.last_tweet_id
  #   # => 0
  #
  def self.last_tweet_id
    0
  end
end
