
#this file will take the message_input (text or braile) and translate to braille to english
require 'pry'
require './lib/dictionary'

class Converter
  #think about if it needs any initialized attributes??

new_reader = FileReader.new

# def method to convert file_content from txt file and remove all the \n
#break out into an array
file_content = new_reader.read # method to pull out the read the file and put it an array
file_content.gsub!(/[\n]/, '')
message_input = file_content.chars

#  create Method to check if it is braille or english (output- yes or no)

# IF BRAILE def method to match the english character to braille, calling from the dictionary hash
# initialize the dictionary and call the method. english_in_to_braille
# execute the match each letter in the message_input array to the dictionary
# it needs to look if andy letters or words are all caps or not & equals capital in our code
# be able to add the capital character

# return value is an array
# turn the array into 3 strings based on the order (first_line, second_line, etc)
# keep adding to the string for each letter
# combine the 3 strings to print together

#if it is braille to text
#read the string, reassign to a horizantal array and then match to the key


first_line_string = ""
second_line_string = ""
third_line_string = ""

message_input.map do |letter|
  translated_braile = english_in_to_braille[letter]
  first_line = translated_braile[0]
  second_line = translated_braile[1]
  third_line = translated_braile[2]

#def a method that will take the first letter and assign the a first, second, third  string
 first_line_string += first_line.to_s
 second_line_string += second_line.to_s
 third_line_string += third_line.to_s # check if this a string or not

 end

first_line_string
second_line_string
third_line_string

#method to combine the 3 strings
def print_all_three
  print first_line_string.concat('\n') + second_line_string.concat('\n') + third_line_string
binding.pry
end

print_all_three
# #take english string inputs and convert each letter to array

#go throuh each element in letter’s array and evaluate each element grab them do something with them.

#look at the hash and return the braille array associated with that key

#each_slice(1) { |a| p a } takes the array and turns it vertical

#take the array to a string to be only 80 positions wide and that will be our output braille file

# class EncodeToBraille
#   def initialize
#     #matched_braile = {}
#     @first_line_string = “”
#     @second_line_string = “”
#     @third_line_string = “”
#
#  end
#
#  def translate
#     message_input.map do |letter|
#       translated_braile = english_in_to_braille[letter]
#       first_line = translated_braile[0]
#       second_line = translated_braile[1]
#       third_line = translated_braile[2]
#
#      first_line_string += first_line.to_s
#       second_line_string += second_line.to_s
#       third_line_string += third_line.to_s
#       puts first_line_string
#       puts second_line_string
#       puts third_line_string
#     end
#   end
#
#
 end
