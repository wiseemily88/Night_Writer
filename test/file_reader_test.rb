gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'

require './lib/file_reader'

class FileReaderTest < Minitest::Test

  def test_filereader_class_exists
    new_reader = FileReader.new
    assert_instance_of FileReader , new_reader
  end

  def test_read_takes_a_txt_file_and_stores_in_array
    skip
    new_reader = FileReader.new

    assert_instance_of Array, new_reader.read("./data/message.txt")
  end



end
