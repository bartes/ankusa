require File.expand_path('helper', File.dirname(__FILE__))

class HasherTest < Test::Unit::TestCase
  def test_stemming
    t = Ankusa::TextHash.new 'Words word a the at fish fishing fishes? /^/  The at a of! @#$!'
    assert_equal t.length, 4
    assert_equal t.word_count, 8
  end
end
