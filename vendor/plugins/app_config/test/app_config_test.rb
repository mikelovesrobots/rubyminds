require 'test/unit'
require '../lib/app_config'

class AppConfigTest < Test::Unit::TestCase
  
  def test_missing_files
    config = ApplicationConfig.init('not_here1', nil)
    assert_equal OpenStruct.new, config
  end
  
  def test_empty_files
    config = ApplicationConfig.init('empty1.yml', 'development')
    assert_equal OpenStruct.new, config
  end
  
  def test_defaults
    config = ApplicationConfig.init('app_config.yml', 'development')
    assert_equal 1, config.size
    assert_equal 'development.com', config.server    
  end
  
  def test_missing_environment
    config = ApplicationConfig.init('app_config.yml', 'nonexistant')
    assert_equal 30, config.size
    assert_equal 'development.com', config.server    
  end
  
  def test_common
    config = ApplicationConfig.init('app_config.yml', 'development')
    assert_equal 1, config.size
    assert_equal 'development.com', config.server
  end
  
  def test_environment
    config = ApplicationConfig.init('app_config.yml', 'production')
    assert_equal 'production.com', config.server
  end
  
  def test_nested
    config = ApplicationConfig.init('app_config.yml', 'development')
    assert_equal 3, config.section.size
  end
  
  def test_array
    config = ApplicationConfig.init('app_config.yml', 'development')
    assert_equal 'yahoo.com', config.section.servers[0].name
    assert_equal 'amazon.com', config.section.servers[1].name
  end
  
  def test_erb
     config = ApplicationConfig.init('app_config.yml', 'development')
     assert_equal 6, config.computed
   end
end
