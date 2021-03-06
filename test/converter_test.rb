gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/converter'
require './lib/file_reader'

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

    converter = Converter.new
    split_lines = converter.split_braille_into_array("0.0.0.0.0.\n00.00.0..0\n....0.0.0.")

    expected = ["0.0.0.0.0.", "00.00.0..0", "....0.0.0."]

    assert_equal expected, split_lines
  end

  def test_assign_braille_updates_instance_variables

    converter = Converter.new
    split_array = converter.assign_braille(["0.0.0.0.0.", "00.00.0..0", "....0.0.0."])

    expected = [
      ["0.","00",".."],
      ["0.",".0",".."],
      ["0.","0.",'0.'],
      ["0.","0.",'0.'],
      ["0.",".0",'0.']
    ]
    assert_equal expected , split_array

  end

  def test_match_braille_to_english

    converter = Converter.new
    input = [
      ["0.","00",".."],
      ["0.",".0",".."],
      ["0.","0.",'0.'],
      ["0.","0.",'0.'],
      ["0.",".0",'0.']
    ]
    expected = "hello"

    assert_equal expected ,converter.match_braille_to_english(input)
  end


  def test_if_identities_capitalized_letters

    converter = Converter.new
    input = [
      ["..","..",".0"],
      ["0.","00",".."],
      ["0.",".0",".."],
      ["0.","0.",'0.'],
      ["0.","0.",'0.'],
      ["0.",".0",'0.']
    ]
    expected = "Hello"

    assert_equal expected ,converter.match_braille_to_english(input)


  end

  def test_if_braille_to_english_translates_to_english

    converter = Converter.new
    input = ("0.0.0.0.0.\n00.00.0..0\n....0.0.0.")
    expected = "hello"

    assert_equal expected ,converter.braille_to_english(input)
  end

  def test_if_braille_to_english_translates_to_english

    converter = Converter.new
    input = ("..0.0.0.0.0.\n..00.00.0..0\n.0....0.0.0.")
    expected = "Hello"

    assert_equal expected ,converter.braille_to_english(input)
  end

  def test_if_braille_to_english_translates_to_english

    converter = Converter.new
    input = ("..0...0.0.0.0.\n..00...00.0..0\n.0...0..0.0.0.")
    expected = "HEllo"

    assert_equal expected ,converter.braille_to_english(input)
  end

  def test_if_braille_to_english_translates_special_characters

    converter = Converter.new
    input = [
    ["..","..",".."],
    ["..","00","0."],
    ["..","..","0."],
    ["..","0.",".."],
    ["..","..","00"],
    ["..","00",".0"],
    ["..","0.","00"]
    ]

    expected = " !',-.?"

    assert_equal expected, converter.match_braille_to_english(input)
  end

  def test_braille_to_eng_translates_capitalString

    converter = Converter.new
    input = <<~EXPECTED
    ..0...0...00..00
    ......0........0
    .0...0...0...0..

EXPECTED
    expected = "ABCD"
    actual = converter.braille_to_english(input.chomp)

    assert_equal expected, actual

  end


  def test_braille_to_eng_translates_80_character_string

    converter = Converter.new
    input = "&"
    expected = " "
    actual = converter.braille_to_english(input)

    assert_equal expected, actual

  end
  def test_braille_to_eng_translates_80_character_string

    converter = Converter.new
    input = <<~EXPECTED
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
    expected = " !',-.?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    actual = converter.braille_to_english(input.chomp)
    assert_equal expected, actual

  end




end
