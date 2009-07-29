class Tweet < RedisModel
  saved_attribute :text

  def self.import
    search = Twitter::Search.new.from('mikelovesrobots').since(last_tweet_identity)
    search.reverse.each do |result| 
      attributes = {
        'identity' => result["id"],
        'text'       => result["text"],
        'created_at' => result["created_at"]
      }

      Tweet.new(attributes).save
    end
  end

  # Returns the most recent Twitter tweet id from the database
  # 
  #   Tweet.last_tweet_identity
  #   # => 2661814374
  #
  def self.last_tweet_identity
    last.first.try(:identity) || 0
  end
end
