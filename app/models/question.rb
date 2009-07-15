class Question
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

  def attributes
    @attributes ||= {}
  end

  def identity
    attributes["identity"]
  end

  def identity=(value)
    attributes["identity"] = value
  end

  def created_at
    attributes["created_at"] 
  end

  def created_at=(value)
    attributes["created_at"] = value
  end
  
  def redis_identity
    "#{self.class}/#{identity}"
  end

  def save
    $redis.set(redis_identity, attributes.to_json)
  end

  def save_to_most_recent_list
    $redis.lpush("Meta/most-recent-questions", redis_identity)
  end

  #
  #   Question.find(1)
  #   # => #<Question:0x19c830c @attributes={...}>
  #   
  #   Question.find([1,2,3,4])
  #   # => [#<Question:...>, #<Question:...>, #<Question:...>, #<Question:...>]
  #
  def self.find(identity)
    if identity.kind_of? Array
      question_ids = Array(identity).collect { |x| "#{self}/#{x}" }
      result = $redis.mget(*question_ids)
      
      if result.present?
        result.collect { |x| x.present? ? self.from_json(x) : nil }.compact
      else
        result
      end
    else
      question_id = "#{self}/#{identity}"
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
    new(JSON.parse(json))
  end
end
