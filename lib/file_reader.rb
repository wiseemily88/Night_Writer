require 'pry'
class FileReader

  def read
    filename = ARGV[0]
    file_content = File.read("./data/#{filename}")
  end

end



#formatted_text = file_content.gsub!(/[\n]/, '')
#formatted_text.gsub!(" ",'')
