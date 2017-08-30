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

  def test_eng_to_braille_return_braille_from_eng
    skip
    converter = Converter.new
    converter.english_to_braille("a")

    assert_equal ["0.","..",".."], converter.translated_braille
  end

  def test_eng_to_braille_returns_capitals

    converter = Converter.new
    converter.english_to_braille("A")
    expected = ["..","..",".0"], ["0.","..",".."]

    assert_equal expected, converter.translated_braille
  end

  def test_eng_to_braille_for_a_word
    converter = Converter.new
    converter.english_to_braille("hello")
    expected = ["0.","00",".."], ["0.",".0",".."], ["0.","0.","0."],
    ["0.","0.","0."], ["0.",".0","0."]

    assert_equal expected, converter.translated_braille

  end

  def test_eng_to_braille_for_a_word
    converter = Converter.new
    converter.english_to_braille("Hello")
    expected = ["..","..",".0"], ["0.","00",".."], ["0.",".0",".."], ["0.","0.","0."],
    ["0.","0.","0."], ["0.",".0","0."]

    assert_equal expected, converter.translated_braille

  end

  def test_combined_lines_returns_3_strings_from_array

    converter = Converter.new
    translated_braille = converter.english_to_braille("a")
    converter.combined_lines(translated_braille)

    expected_first_line = "0."
    expected_second_line = ".."
    expected_third_line = ".."

    assert_equal expected_first_line, converter.first_line
    assert_equal expected_second_line, converter.second_line
    assert_equal expected_third_line, converter.third_line
  end

  def test_first_lines_returns_a_strings_from_array

    converter = Converter.new
    translated_braille = converter.english_to_braille("hello")
    converter.first_lines(translated_braille)

    expected_first_line = "0.0.0.0.0."

    assert_equal expected_first_line, converter.first_line
  end

  def test_second_lines_returns_3_strings_from_array

    converter = Converter.new
    translated_braille = converter.english_to_braille("hello")
    converter.second_lines(translated_braille)

    expected_second_line = "00.00.0..0"

    assert_equal expected_second_line, converter.second_line
  end

  def test_third_lines_returns_3_strings_from_array

    converter = Converter.new
    translated_braille = converter.english_to_braille("hello")
    converter.third_lines(translated_braille)

    expected_third_line = "....0.0.0."

    assert_equal expected_third_line, converter.third_line
  end

  def test_print_transpose_returns_3_strings_together

    converter = Converter.new
    translated_braille = converter.english_to_braille("a")
    #converter.split_lines(translated_braille)- pass through

    expected = "0.\n..\n.."

    assert_equal expected, converter.print_transpose(translated_braille)
  end

  def test_print_transpose_returns_3_strings_together
    converter = Converter.new
    translated_braille = converter.english_to_braille("hello")
    converter.combined_lines(translated_braille)

    expected = "0.0.0.0.0.\n00.00.0..0\n....0.0.0."
    assert_equal expected, converter.print_transpose(translated_braille)
  end

  def test_split_lines_returns_3_arrays
    converter = Converter.new
    split_lines = converter.split_braille_on_new_line("0.0.0.0.0.\n00.00.0..0\n....0.0.0.")

    expected = [["0.0.0.0.0."], ["00.00.0..0"], ["....0.0.0."]]

    assert_equal expected, split_lines
  end

  def test_assign_braille_updates_instance_variables
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
