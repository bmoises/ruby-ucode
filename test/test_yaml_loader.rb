require 'helper'

class TestYamlLoader < Test::Unit::TestCase
  should "raise an exception if new method is called" do
    assert_raise(NoMethodError){ yaml_loader = YamlLoader.new }
  end
 
  should "raise an exception if path is not defined" do
    assert_raise(YamlPathNotDefined){ yaml_loader = YamlLoader.instance }
  end
  
  should "get an instance of YamlLoader and load yaml files" do
    path = File.join(FIXTURES_PATH,'yaml')
    yaml_loader = YamlLoader.instance(path)
    assert_equal yaml_loader.array, [1, 2, 3]
    assert_equal yaml_loader.hash, {"a"=>1, "b"=>2, "c"=>3}
  end
end
