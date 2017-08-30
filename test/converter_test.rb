gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/converter'
require './lib/file_reader'
require 'pry'

class ConverterTest < Minitest::Test

  def test_converter_class_exists
    converter = Converter.new
    assert_instance_of Converter , converter
  end

  def test_translate_characters_braille_from_eng
    converter = Converter.new
    translated_characters = converter.translate_characters("a")

    assert_equal [["0.","..",".."]], translated_characters
  end

  def test_translate_characters_returns_capitals

    converter = Converter.new
    translate_characters = converter.translate_characters("A")
    expected = ["..","..",".0"], ["0.","..",".."]

    assert_equal expected, translate_characters
  end

  def test_translate_characters_for_a_word

    converter = Converter.new
    translate_characters = converter.translate_characters("hello")
    expected = ["0.","00",".."], ["0.",".0",".."], ["0.","0.","0."],
    ["0.","0.","0."], ["0.",".0","0."]

    assert_equal expected, translate_characters
  end

  def test_translate_characters_for_a_word_with_capital
    converter = Converter.new
    translated_braille = converter.translate_characters("Hello")
    expected = ["..","..",".0"], ["0.","00",".."], ["0.",".0",".."], ["0.","0.","0."],
    ["0.","0.","0."], ["0.",".0","0."]

    assert_equal expected, translated_braille
  end

  def test_combined_lines_transposes_a_letter
    converter = Converter.new
    expected = "0.\n..\n.."

    assert_equal expected, converter.combined_lines("0.", "..", "..")
  end

  def test_combined_lines_transposes_a_word
    converter = Converter.new
    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0."

    first_line = "0.0.0.0.0."
    second_line = "00.00.0..0"
    third_line  = "....0.0.0."

    assert_equal expected, converter.combined_lines(first_line, second_line, third_line)
  end

  def test_combined_lines_wraps_at_80_characters
    converter = Converter.new
    expected = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................"
    first_line = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0."
    second_line = "................................................................................"
    third_line = "................................................................................"

    assert_equal expected, converter.combined_lines(first_line, second_line, third_line)
  end

  def test_combined_lines_wraps_at_81_characters
    converter = Converter.new
    expected = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................\n0.\n..\n.."
    first_line = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0."
    second_line = ".................................................................................."
    third_line = ".................................................................................."

    assert_equal expected, converter.combined_lines(first_line, second_line, third_line)
  end


  def test_first_lines_returns_a_string_of_index_0_in_arrays
    converter = Converter.new

    input = ["0.","00",".."], ["0.",".0",".."], ["0.","0.","0."],
    ["0.","0.","0."], ["0.",".0","0."]
    expected_first_line = "0.0.0.0.0."

    assert_equal expected_first_line, converter.first_lines(input)
  end

  def test_second_lines_returns_a_string_of_index_1_in_arrays
    converter = Converter.new

    input = ["0.","00",".."], ["0.",".0",".."], ["0.","0.","0."],
    ["0.","0.","0."], ["0.",".0","0."]
    expected_second_line = "00.00.0..0"

    assert_equal expected_second_line, converter.second_lines(input)
  end

  def test_third_lines_returns_a_string_of_index_2_in_arrays
    converter = Converter.new
    input = ["0.","00",".."], ["0.",".0",".."], ["0.","0.","0."],
    ["0.","0.","0."], ["0.",".0","0."]
    expected_third_line = "....0.0.0."

    assert_equal expected_third_line, converter.third_lines(input)
  end

  def test_eng_to_braille_translates_a_letter_and_formats_message
    converter = Converter.new
    expected = "0.\n..\n.."

    assert_equal expected, converter.eng_to_braille("a")
  end

  def test_eng_to_braille_translates_a_word_and_formats_message
    converter = Converter.new
    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0."

    assert_equal expected, converter.eng_to_braille("hello")
  end

  def test_eng_to_braille_translates_a_capital_word_and_formats_message
    converter = Converter.new
    expected = "..0.0.0.0.0.\n..00.00.0..0\n.0....0.0.0."

    assert_equal expected, converter.eng_to_braille("Hello")
  end

  def test_eng_to_braille_translates_two_capitals_and_formats_message
    converter = Converter.new
    expected = "..0...0.0.0.0.\n..00...00.0..0\n.0...0..0.0.0."

    assert_equal expected, converter.eng_to_braille("HEllo")
  end

  def test_eng_to_braille_translates_special_characters_and_formats_message
    converter = Converter.new
    expected = "..............\n00....0...000.\n0...0...00.000"
    input = "! ',-.?"

    assert_equal expected, converter.eng_to_braille(input)
  end

  def test_eng_to_braille_translates_80_character_string
    converter = Converter.new
    expected = "0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.\n................................................................................\n................................................................................"
    input = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

    assert_equal expected, converter.eng_to_braille(input)
  end

  def test_eng_to_braille_translates_80_character_string
    converter = Converter.new
    expected = <<~EXPECTED
      ..............0.0.00000.00000..0.00.0.00000.00000..0.00.0..000000...0...0...00..
      ..00..0...000...0....0.00.00000.00..0....0.00.00000.00..0.00...0.0......0.......
      ..0.0...00.000....................0.0.0.0.0.0.0.0.0.0.0000.0000000.0...0...0...0
      00..0...00..00..0....0...0..0...0...00..00..0...00..00..0....0...0..0...0....0..
      .0...0..0...00..00..0...00......0........0...0..0...00..00..0...00......0...00..
      ...0...0...0...0...0...0...00..00..00..00..00..00..00..00..00..00..000.000.0.0.0
      00..00..0.
      .....0...0
      00.000.000
EXPECTED
    input = " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    actual = converter.eng_to_braille(input)

    assert_equal expected.chomp, actual

  end

  def test_split_lines_returns_3_arrays
    skip
    converter = Converter.new
    split_lines = converter.split_braille_on_new_line("0.0.0.0.0.\n00.00.0..0\n....0.0.0.")

    expected = [["0.0.0.0.0."], ["00.00.0..0"], ["....0.0.0."]]

    assert_equal expected, split_lines
  end

  def test_assign_braille_updates_instance_variables
    skip
    converter = Converter.new
    broken_lines = converter.assign_braille("0.0.0.0.0.\n00.00.0..0\n....0.0.0.")
    first_line_braile = "0.0.0.0.0."
    second_line_braile = "00.00.0..0"
    third_line_braile = "....0.0.0."

    assert_equal converter.first_line_braille, broken_lines[0].to_s
    assert_equal converter.second_line_braille, broken_lines[1].to_s
    assert_equal converter.third_line_braille, broken_lines[2].to_s
  end

  def test_braille_to_english_returns_braille
    skip
    converter = Converter.new
    input = "0.0.0.0.0.\n00.00.0..0\n....0.0.0."
    translated_english = converter.braille_to_english(input)

    expected = "hello"
    assert_equal expected, converter.translated_english
  end






  # def test_is_braille_returns_false_when_text_is_eng
  #   skip
  #   file_content = FileReader.new(Read.import("./data/message.txt"))
  #
  #   refute file_content.is_braille?
  # end
  #
  # def test_is_braille_returns_true_when_text_is_braille
  #   skip
  #   file_content = FileReader.new(Read.import("./data/braille.txt"))
  #
  #   assert file_content.is_braille?
  # end
  #
  # def test_braille_or_english_executes
  #   skip
  #   file_content = FileReader.new(Read.import("./data/braille.txt"))
  #
  #   assert file_content.is_braille?
  # end


end
