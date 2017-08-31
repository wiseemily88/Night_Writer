require "./lib/dictionary"
require "./lib/converter"
require "./lib/file_reader"
require "./lib/file_writer"

class NightWrite

  def read_reconvert_format_orginal_message
    file_content = read_and_format_new_file
    translated_data = convert(file_content)
    export_file = write_file(translated_data)
    puts "Created '#{ARGV[1]}' containing #{translated_data.length} characters."
  end

  def read_and_format_new_file
   new_file = FileReader.new
   raw_content = new_file.read
  end

  def convert(file_content)
  new_converter = Converter.new
  translated_data = new_converter.braille_to_english(file_content)
  end

  def write_file(translated_data)
    new_file = FileWriter.new
    export_file = new_file.write_text(translated_data)
  end

end

nr = NightWrite.new
nr.read_reconvert_format_orginal_message
