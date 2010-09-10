require 'helper'

class DummyXmlStream
  include XmlStream
end
# Test xml file has the following format
#<?xml version="1.0"?>
#<catalog>
#   <book id="bk101">
#      <author>Gambardella, Matthew</author>
#      <title>XML Developer's Guide</title>
#      <genre>Computer</genre>
#      <price>44.95</price>
#      <publish_date>2000-10-01</publish_date>
#      <description>An in-depth look at creating applications 
#      with XML.</description>
#   </book>
#    ...
#</catalog>
class TestXmlStream < Test::Unit::TestCase
  
  should "process an xml file by streaming" do
    books_xml = File.join(FIXTURES_PATH,'books.xml')
    dummy_xml_stream = DummyXmlStream.new
    dummy_xml_stream.xml_stream(books_xml,"<book(\s|>)","<\/book>","<\?xml|<catalog|<\/catalog>") do |book|
      assert book.match(/<book(.?|\n)+<\/book>/)
    end
  end
end


