# Given an xml file, start and end markers,
# xml_stream will allow you to stream xml.
# The benefits of streaming become apparent when dealing with large files
# See test case for usage
module XmlStream
  def xml_stream(file, xml_start, xml_end, skip)
    if !File.exists?(file)
      raise "File Does not exists"
    end
    file = File.new(file, "r")
    item = ""
    header = file.gets #<?xml version="1.0"?>
    while ( line = file.gets )
      line = line.gsub(/^\s\s/,"")
      
      if line =~ /#{xml_start}/
        item = line 
      elsif line =~ /#{xml_end}/
        item << line
        yield item
      elsif !( line =~ /^(#{skip})/) # skip if line starts with the following
        item << line
      end
    end
    file.close
  end
end
