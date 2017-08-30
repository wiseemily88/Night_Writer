
require './lib/dictionary'
require './lib/file_reader'


class Converter
  attr_reader :translated_braille, :first_line, :second_line, :third_line

  def initialize
    @translated_braille = []
    @first_line = ""
    @second_line = ""
    @third_line = ""
  end

  def english_to_braille(messages)
    split_message_array = messages.chars
    split_message_array.each do |letter|
      if ("a".."z").include?(letter)
        @translated_braille << Dictionary.english_in_to_braille[letter]
      elsif ("A".."Z").include?(letter)
        @translated_braille << ["..","..",".0"] << Dictionary.english_in_to_braille[letter.downcase]
      end
    end
    @translated_braille
  end

  def braille_to_english(messages)
  #take the 
  end


  def split_lines(translated_braille)
    first_lines(translated_braille)
    second_lines(translated_braille)
    third_lines(translated_braille)
  end

  def first_lines(translated_braille)
    index_count = 0
    translated_braille.count.times do |index_count|
      @first_line << translated_braille[index_count][0]
      index_count+= 1

    end
  end

  def second_lines(translated_braille)
    index_count = 0
    translated_braille.count.times do |index_count|
      @second_line << translated_braille[index_count][1]
      index_count+= 1
    end
  end

  def third_lines(translated_braille)
    index_count = 0
    translated_braille.count.times do |index_count|
      @third_line << translated_braille[index_count][2]
      index_count+= 1
    end
  end


  def print_transpose(translated_braille)

    temp = first_line + "\n"
    temp1 = second_line + "\n"
    temp2 = third_line
    transposed = temp + temp1 + temp2

  end



end
#   attr_reader :first_line_string, :second_line_string, :third_line_string
#
#   def initialize
#     @first_line_string = ""
#     @second_line_string = ""
#     @third_line_string = ""
#     @formatted_text = ""
#
#   end
#
#   def convert_file_content_to_array
#     #file_content = new_reader.read - move this to night-write
#     file_content.gsub!(/[\n]/, '')
#     @formatted_text = file_content.chars
#   end
#
#   def is_braille?
#     file_content.join.scan(/[a-zA-Z1-9]/).empty?
#   end
#
#   def braille_or_english_path
#     if is_braille?
#       match_braille_to_english(@formatted_text)
#     else
#       match_english_to_braille(@formatted_text)
#     end
#   end
#
#   def check_for_capitals
#     #if it is english check the message_content array has any upcase
#   end
#
#   def match_english_to_braille(@formatted_text)
#     translated_braile = []
#     message_input.map do |letter|
#
#       translated_braile = @dictionary.english_in_to_braille[letter]
#       first_line = translated_braile[0]
#       second_line = translated_braile[1]
#       third_line = translated_braile[2]
#
#     #def a method that will take the first letter and assign the a first, second, third  string
#      first_line_string += first_line.to_s
#      second_line_string += second_line.to_s
#      third_line_string += third_line.to_s # check if this a string or not
#
#      end
#
#   def print_all_three(first_line_string, second_line_string, third_line_string)
#     combined_string = first_line_string.concat('\n') + second_line_string.concat('\n') + third_line_strin
#      combined_string
#   end
#
#   def match_braille_to_english(message_input)
#
#     message_input.map do |letter|
#       #new_dictionary = Dictionary.new
#       translated_braile = Dictionary.braille_to_english[letter]
#       split_lines
#     end
#   end
#
#   def split_lines (translated_braile)
#       first_line = translated_braile[0]
#       second_line = translated_braile[1]
#       third_line = translated_braile[2]
#   end
#
#     #def a method that will take the first letter and assign the a first, second, third  string
#   def create_line_strings(first_line, second_line, third_line)
#      first_line_string += first_line
#      second_line_string += second_line
#      third_line_string += third_line
#   end
#
#
#
#
# end
#
#
#
# #
# # # IF BRAILE def method to match the english character to braille, calling from the dictionary hash
# # # initialize the dictionary and call the method. english_in_to_braille
# # # execute the match each letter in the message_input array to the dictionary
# # # it needs to look if andy letters or words are all caps or not & equals capital in our code
# # # be able to add the capital character
# #
# # # return value is an array
# # # turn the array into 3 strings based on the order (first_line, second_line, etc)
# # # keep adding to the string for each letter
# # # combine the 3 strings to print together
# #
# # #if it is braille to text
# # #read the string, reassign to a horizantal array and then match to the key
# #
# # #method to combine the 3 strings
# # def print_all_three
# #   print first_line_string.concat('\n') + second_line_string.concat('\n') + third_line_string
# # binding.pry
# # end
# #
# # print_all_three
# # # #take english string inputs and convert each letter to array
# #
# # #go throuh each element in letter’s array and evaluate each element grab them do something with them.
# #
# # #look at the hash and return the braille array associated with that key
# #
# # #each_slice(1) { |a| p a } takes the array and turns it vertical
# #
# # #take the array to a string to be only 80 positions wide and that will be our output braille file
