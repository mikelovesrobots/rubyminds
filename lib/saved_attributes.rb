module SavedAttributes
  def saved_attribute(*names)
    names.each do |name|
      define_method(name) do
        attributes[name.to_s]
      end

      define_method("#{name}=") do |value|
        attributes[name.to_s] = value
      end
    end
  end

  alias saved_attributes saved_attribute
end
