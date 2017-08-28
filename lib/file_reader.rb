
require 'pry'
require './lib/dictionary'
#read the file and and import the string
class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end
require ‘pry’
require ‘./lib/braile’
#read the file and and import the string
class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end
new_reader = FileReader.new
file_content = new_reader.read
file_content.gsub!(/[\n]/, ‘’)
message_input = file_content.chars

#matched_braile = {}
first_line_string = “”
second_line_string = “”
third_line_string = “”

message_input.map do |letter|
  translated_braile = english_in_to_braille[letter]
  first_line = translated_braile[0]
  second_line = translated_braile[1]
  third_line = translated_braile[2]

 first_line_string += first_line.to_s
  second_line_string += second_line.to_s
  third_line_string += third_line.to_s

end

puts first_line_string
puts second_line_string
puts third_line_string

#find out how to make it wrap around after 80chars




# binding.pry



# need to take out all the \n characters
 # this split it in to an array
 #then run some code to match it to braile
file reader^^
