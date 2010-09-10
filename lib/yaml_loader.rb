# Singleton class
# Public resource, do not load config files that other objects should not have access to
# * usage:
#    @yml = YmlLoader.instance
#    @yml.load_default_directory
#    @yml.load_directory(yml_directory)
require 'yaml'
class YamlPathNotDefined < StandardError; end

class YamlLoader
  #include Singleton
  attr_accessor :loaded_default, :path

  private_class_method :new
  @@instance = nil

  # will provide instance
  def YamlLoader.instance(path=nil)

    @path = path
    if path == nil && !@path
      raise YamlPathNotDefined
    end
    
    if !@@instance
      @@instance = new
      @@instance.load_default_directory(@path)
    end
    @@instance
  end
    
  class << self

    # Given a filesystem file, will call string_to_yaml when it loads file
    def yaml_load(file_name)
       string_to_yaml(File.open( "#{file_name}" ) )
    end

    # given a string, will convert to YAML
    def string_to_yaml(str)
      return YAML::load(str)
    end
  end

  # Loads default content
  def load_default_directory(path)
    if !@loaded_default
      load_directory(path)
      @loaded_default = true
    end
  end

  # given a directory in the system, it will load all files in given directory
  def load_directory(directory=nil)
    # Given a directory, it will load yml files and set instance variables that
    # match the basename without extention.
    list_files(directory,:all,'.yml').each do |file|
      name = File.basename(file,'.yml')
      self.class.send(:attr_accessor, name.intern)
      data = YamlLoader::yaml_load(file)
      self.send("#{name}=",data)
    end
  end
  

  private
  def list_files(directory,match=:all,ext=".csv")
    files = []
    get_file_list("#{directory}/*#{ext}").each do |f|
      if match == :all
        files << f
      else
        files << f if f.match(match)
      end
    end
    files
  end

  # Returns a list of files given a pattern/directory
  def get_file_list(path_pattern)
    return Dir[path_pattern].sort
  end
end