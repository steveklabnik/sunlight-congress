require 'sunlight/congress'

class TestIntegrationCongress < MiniTest::Unit::TestCase
  ['title'].each do |attr|
    define_method "test_#{attr}" do
      l = Sunlight::Congress::Bill.new(attr => "foo")
      assert_equal "foo", l.send(attr)
    end
  end
end
