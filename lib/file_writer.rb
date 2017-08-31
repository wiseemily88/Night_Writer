class FileWriter
  require 'pry'


  def write_text(translated_data)
    outfile = File.open("./data/#{ARGV[1]}", 'w')
    outfile.write(translated_data)
    outfile.close
  end
end


new_file = FileWriter.new
new_file.write_text("text")
