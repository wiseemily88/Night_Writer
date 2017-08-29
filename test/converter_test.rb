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

  def test_convert_to_array_reads_txt_in_array
    skip
    converter = Converter.new

    file_content = FileReader.new(Read.import("./data/message.txt"))
    assert_instance_of Array, file_content

  end

  def test_is_braille_returns_false_when_text_is_eng
    skip
    file_content = FileReader.new(Read.import("./data/message.txt"))

    refute file_content.is_braille?
  end

  def test_is_braille_returns_true_when_text_is_braille
    skip
    file_content = FileReader.new(Read.import("./data/braille.txt"))

    assert file_content.is_braille?
  end

  def test_braille_or_english_executes
    skip
    file_content = FileReader.new(Read.import("./data/braille.txt"))

    assert file_content.is_braille?
  end


end
