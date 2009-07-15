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

  def self.find(identity)
    if identity.kind_of? Array
      question_ids = Array(identity).collect { |x| "#{self}/#{x}" }
      result = $redis.mget(*question_ids)
      
      if result.present?
        result.collect { |x| x.present? ? Question.from_json(x) : nil }.compact
      else
        result
      end
    else
      question_id = "#{self}/#{identity}"
      if result = $redis.get(question_id)
        Question.from_json result
      end
    end
  end
  
  def self.[](identity)
    find(identity)
  end 
  def self.from_json(json)
    new(JSON.parse(json))
  end
end
