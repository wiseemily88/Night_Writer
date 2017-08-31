require 'pry'
require './lib/dictionary'
require './lib/file_reader'


class Converter

  def eng_to_braille(file_content)
    translated_braille = translate_characters(file_content)
    first_line = first_lines(translated_braille)
    second_line = second_lines(translated_braille)
    third_line = third_lines(translated_braille)
    combined_lines = combined_lines(first_line, second_line, third_line)
  end


  def translate_characters(file_content)
    translated_braille = []
    split_message_array = file_content.chars
    split_message_array.each do |letter|
      if ("a".."z").include?(letter)
        translated_braille << Dictionary.english_in_to_braille[letter]
      elsif ("A".."Z").include?(letter)
        translated_braille << ["..","..",".0"] << Dictionary.english_in_to_braille[letter.downcase]
      elsif (" ".."?").include?(letter)
        translated_braille << Dictionary.english_in_to_braille[letter]
      end
    end
    translated_braille
  end


  def combined_lines(first_line, second_line, third_line)
    message_array = []
    while first_line.length > 0

      formatted_first_line = first_line.slice!(0..79)
      formatted_second_line = second_line.slice!(0..79)
      formatted_third_line = third_line.slice!(0..79)
      message_array << formatted_first_line.concat("\n") + formatted_second_line.concat("\n") + formatted_third_line
    end
    message_array.join("\n")
  end

  def first_lines(translated_braille)
    first_line = ""
    index_count = 0
    translated_braille.count.times do |index_count|
      first_line << translated_braille[index_count][0]
      index_count+= 1
    end
    first_line
  end

  def second_lines(translated_braille)
    second_line = ""
    index_count = 0
    translated_braille.count.times do |index_count|
      second_line << translated_braille[index_count][1]
      index_count+= 1
    end
    second_line
  end

  def third_lines(translated_braille)
    third_line = ""
    index_count = 0
    translated_braille.count.times do |index_count|
      third_line << translated_braille[index_count][2]
      index_count+= 1
    end
    third_line
  end


  def braille_to_english(file_content)
     split_array = split_braille_into_array(file_content)
     original_lines = original_lines(split_array)
     braille_characters = assign_braille(original_lines)
     translated_english = match_braille_to_english(braille_characters)
  end

  def split_braille_into_array(file_content)
    split_array = file_content.split("\n")
  end

  def original_lines(split_array)
    while split_array.length > 3
      split_array[0] += split_array.delete_at(3)
      split_array[1] += split_array.delete_at(3)
      split_array[2] += split_array.delete_at(3)
    end
    split_array
  end

  def assign_braille(split_array)

    braille_characters = []
    while split_array.first.length > 0
      braille_character = []
      braille_character << split_array[0].slice!(0..1)
      braille_character << split_array[1].slice!(0..1)
      braille_character << split_array[2].slice!(0..1)
      braille_characters << braille_character
    end
    braille_characters
  end

  def match_braille_to_english(braille_characters)
    translated_english = []
    braille_characters.map do |braille_character|
      translated_english << Dictionary.braille_to_english[braille_character]
   end
    fix_for_capitals(translated_english).uniq.join


  end

  def fix_for_capitals(translated_english)
    translated_braille_with_capitals = []
    translated_english.map.with_index do |letter, index|
      if letter.eql?( "&")
        translated_braille_with_capitals << translated_english.delete_at(index+1).upcase
      else
        translated_braille_with_capitals  << letter

      end
    end
  end

end
