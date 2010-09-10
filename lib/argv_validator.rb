# Given an array of the form ["--argv1=0", "--argv-2=two", ... ]
# ArgvValidator will parse array and return an object that can be used to access
# arguments defined at runtime
# USE:
# ARGV = ["--argv1=0", "--argv2=two"]
# av = ArgvValidator.new(ARGV)
# av.argv1 #"0"
# av.argv2 #"two"

# TODO: update code to detect data types and return intended data type.
# possibly use the following regex?
#   s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true

class ArgvValidator
  attr_accessor :options, :methods, :arguments
  def initialize(argvs)
    @options, @methods, @arguments = {}, [], 0
    argvs.each do |argv|
      arg = argv.split("=")
      @options[arg.first] = arg.last
      @methods << clean_method(arg.first)
      @arguments += 1
    end
    @options.each do |key,val|
      self.class.send("define_method", clean_method(key) ) do
        return @options[key]
      end
    end

  end
  
  def total_arguments
    @arguments
  end
  
  def has_method?(method)
    @methods.include?(method.to_s)
  end
  
  def clean_method(method)
    method.gsub(/--/, "").gsub(/-/, "_")
  end
end

module ArgvIncludes
  class RequiredArgumentNotSpecified < StandardError; end
  class NeedToInitializeArgValidator < StandardError; end

  attr_accessor :argv

  def validate_args(required_args, argv=@argv)
    raise NeedToInitializeArgValidator unless argv
    required_args.each do |argv|
      if !@argv.options[argv]
        raise RequiredArgumentNotSpecified, "'#{argv}' is a required argument that you forgot to specify"
      end
    end
  end
end