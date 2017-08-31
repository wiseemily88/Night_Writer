gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'


require './lib/night_read'

class NightReadTest < Minitest::Test

  def test_NightRead_class_exists
    skip
    nr = NightRead.new
    assert_instance_of NightRead , nr
  end

  def test_read_and_format_reads_raw_content

    nr = NightRead.new
    input = "./data/message.txt"
    expected = "hello world"
    actual = nr.read_and_format_new_file(input)

    assert_equal expected, actual
  end

  def test_convert_returns_translated_braile

    nr = NightRead.new
    input = "hello world"
    expected = ("..0.0.0.0.0.\n..00.00.0..0\n.0....0.0.0.")
    actual = convert(input)

    assert_equal expected, actual
  end

  def test_write_file_creates_file
    skip
    nr = NightRead.new
    input = ("..0.0.0.0.0.\n..00.00.0..0\n.0....0.0.0.")

    actual = write_file(input)

    assert_equal expected, actual
  end

end
