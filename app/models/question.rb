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

  def self.find(identity)
    if result = $redis.get("#{self}/#{identity}")
      Question.new(JSON.parse(result))
    end
  end
end
