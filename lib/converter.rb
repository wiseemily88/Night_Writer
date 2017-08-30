
require './lib/dictionary'
require './lib/file_reader'


class Converter
  attr_reader :translated_braille, :first_line, :second_line,
  :third_line, :first_line_braille, :second_line_braille, :third_line_braille

  def initialize
    @translated_braille = []
    @first_line = ""
    @second_line = ""
    @third_line = ""
    @first_line_braille = []
    @second_line_braille = []
    @third_line_braille = []

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


  def split_braille_on_new_line(messages)
    messages.split("\n").each_slice(1).to_a
  end

  def assign_braille(messages)
    broken_lines = split_braille_on_new_line(messages)
    @first_line_braille = broken_lines[0].to_s
    @second_line_braille = broken_lines [1].to_s
    @third_line_braille = broken_lines [2].to_s
    broken_lines
  end


 def braille_to_english(split_lines)
  #   index_count = 0
  #
  #   split_lines[0].count times do |line|
  #     translated_english << split_lines[0][0..1]
end

  #take the string and assign the values to an Array
  #split the string at the \n
  # match the array with the appropriate key value in the hash



  def combined_lines(translated_braille)
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
