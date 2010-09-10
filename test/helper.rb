require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..','lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

# Load all files in lib folder
Dir[File.join(File.dirname(__FILE__), '..','lib','*.rb')].collect{|f| require f }

FIXTURES_PATH = File.join(File.dirname(__FILE__), 'fixtures')
class Test::Unit::TestCase
end
