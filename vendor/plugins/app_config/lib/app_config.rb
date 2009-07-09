require 'ostruct'
require 'yaml'
require 'erb'

# == Summary
# This is API documentation, NOT documentation on how to use this plugin.  For that, see the README.
module ApplicationConfig
  
  # Create a config object (OpenStruct) from a yaml file.
  def self.init(file, environment)
    yaml = YAML.load(ERB.new(IO.read(file)).result) if File.exists?(file)
    defaults = yaml['defaults'] if environment and yaml.is_a?(Hash) and yaml['defaults']
    overrides = yaml[environment] if environment and yaml.is_a?(Hash) and yaml[environment]
    conf = recursive_merge(defaults, overrides)
    conf = {} if !conf or conf.empty?
    (!conf or conf.empty?) ? OpenStruct.new : convert(conf)    
  end
  
  # Recursively converts Hashes to OpenStructs (including Hashes inside Arrays)
  def self.convert(h) #:nodoc:
    s = OpenStruct.new
    h.each do |k, v|
      s.new_ostruct_member(k)
      if v.instance_of?(Hash)
        s.send( (k+'=').to_sym, convert(v))
      elsif v.instance_of?(Array)
        converted_array = v.collect { |e| e.instance_of?(Hash) ? convert(e) : e }
        s.send( (k+'=').to_sym, converted_array)
      else
        s.send( (k+'=').to_sym, v)
      end
    end
    s
  end
  
  # Recursively merges hashes.  h2 will overwrite h1.
  def self.recursive_merge(h1, h2) #:nodoc:
    return h1 if h1.nil? or h2.nil?
    h1.merge(h2){ |k, v1, v2| v2.kind_of?(Hash) ? recursive_merge(v1, v2) : v2 }
  end
end