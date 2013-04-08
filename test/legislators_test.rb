require 'sunlight/congress'

class TestIntegrationCongress < MiniTest::Unit::TestCase
  ['first_name', 'last_name'].each do |attr|
    define_method "test_#{attr}" do
      l = Sunlight::Congress::Legislator.new(attr => "foo")
      assert_equal "foo", l.send(attr)
    end
  end
end
