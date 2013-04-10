require 'sunlight/congress'

class TestDistrict < MiniTest::Unit::TestCase
  ['state', 'district'].each do |attr|
    define_method "test_#{attr}" do
      l = Sunlight::Congress::District.new(attr => "foo")
      assert_equal "foo", l.send(attr)
    end
  end
end
