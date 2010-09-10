require 'helper'

class TestArgvIncludes
  include ArgvIncludes
end

class TestArgvValidator < Test::Unit::TestCase

  should "not have any arguments" do
    av = ArgvValidator.new([])
    assert_equal av.total_arguments, 0
  end
  
  should "have the following arguments" do
    av = ArgvValidator.new(["--myargs=0"])
    assert_equal av.total_arguments, 1
    assert_equal av.myargs,"0"
  end

  should "process arguments with - in argument name" do
    av = ArgvValidator.new(["--myarg1=0", "--myarg-2=two"])
    assert_equal av.total_arguments, 2
    assert_equal av.myarg1,"0"
    assert_equal av.myarg_2, "two"
  end
  
  should "raise an exception if method does not exists" do
    av = ArgvValidator.new(["--myarg1=0", "--myarg-2=two"])
    assert_raise(NoMethodError){ av.myarg3 }
  end
  
  # testing ArgvIncludes Module
  should "raise and exception when " do
    test_argv_includes = TestArgvIncludes.new
    assert_raise(ArgvIncludes::NeedToInitializeArgValidator){ test_argv_includes.validate_args(["--myarg1"]) }
  end
  should "raise and exception when required argument is not specified in input" do
    test_argv_includes = TestArgvIncludes.new
    test_argv_includes.argv = ArgvValidator.new(["--myarg1=0", "--myarg-2=two"])
    assert_raise(ArgvIncludes::RequiredArgumentNotSpecified){ test_argv_includes.validate_args(["--myarg3"]) }
  end
  
end
