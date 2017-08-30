
class FileReader
  attr_reader :file_content
  attr_accessor :formatted_text

  def initialize
    @file_content = file_content
    @formatted_text = ""
    @filename = ""
  end

  def read
    filename = ARGV[0]
    @file_content = File.read(filename)
    @formatted_text = file_content.gsub!(/[\n]/, '')
    @formatted_text.gsub!(" ",'')
  end

end
