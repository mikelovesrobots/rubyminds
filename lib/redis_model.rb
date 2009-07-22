class RedisModel
  extend SavedAttributes
  saved_attributes :identity, :created_at

  def initialize(params={})
    before_initialize
    params.each { |key, value| self.send("#{key}=", value) }
    after_initialize
  end

  def before_initialize
  end

  def after_initialize
    self.created_at ||= Time.now
  end

  def before_save
  end

  def after_save
    save_to_most_recent_list
  end

  def attributes
    @attributes ||= {}
  end
  
  # Saves the attributes hash to the redis database
  #
  #   question.save
  #   Redis.find(question.redis_identity)
  #   # => <Question...>
  #
  def save
    before_save
    $redis.set(redis_identity, attributes.to_json)
    after_save
  end
 
  # Returns the redis identity key for this instance
  #
  #   question = Question.new "identity" => "i-like-pie"
  #   question.redis_identity
  #   # => "question/i-like-pie"
  #
  def redis_identity
    self.class.redis_identity(identity)
  end

  # Returns the redis identity key for a given identity string
  #
  #   Question.redis_identity("i-like-pie")
  #   # => "question/i-like-pie"
  #
  def self.redis_identity(identity)
    "#{redis_namespace}/#{identity}"
  end

  def self.redis_most_recent_list_identity
    "#{redis_namespace}/most-recent"
  end

  def self.redis_namespace
    self.to_s.underscore
  end

  # Saves this record to the most_recent_list for this class
  def save_to_most_recent_list
    $redis.lpush(self.class.redis_most_recent_list_identity, identity)
  end

  # Retrieves a record (or number of records in a convenient and efficient multi-get) 
  # from the redis database.
  #
  #   Question.find(1)
  #   # => #<Question:0x19c830c @attributes={...}>
  #   
  #   Question.find([1,2,3,4])
  #   # => [#<Question:...>, #<Question:...>, #<Question:...>, #<Question:...>]
  #
  def self.find(identity)
    if identity.kind_of? Array
      if identity.empty?
        []
      else
        record_ids = Array(identity).collect { |x| redis_identity(x) }
        result = $redis.mget(*record_ids)
        
        if result.present?
          result.collect { |x| x.present? ? self.from_json(x) : nil }.compact
        else
          result
        end
      end
    else
      question_id = redis_identity(identity)
      if result = $redis.get(question_id)
        self.from_json result
      end
    end
  end
  
  # A shortcut / alias to the #find class method.
  #
  #   Question[1]
  #   # => #<Question:0x19c830c @attributes={...}>
  #   
  def self.[](identity)
    find(identity)
  end 

  # Creates an instance of an object of this type from a json version
  # of the attributes hash.  Used mainly for deserializing records from
  # redis.
  #
  #   Question.from_json(json_text)
  #   # => #<Question:...>
  #
  def self.from_json(json)
    new(ActiveSupport::JSON.decode(json))
  end

  def self.last_ids(n = 1)
    $redis.lrange redis_most_recent_list_identity, 0, n - 1
  end

  def self.last(n = 1)
    find(last_ids(n))
  end
end
