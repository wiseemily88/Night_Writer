
require 'pry'
require './lib/dictionary'

class FileReader
  attr_reader :file_content

  def initialize
    @file_name =
  end

  def read
    filename = ARGV[0]
    File.read(filename)
  end

end
