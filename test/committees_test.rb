require 'sunlight/congress'

class TestIntegrationCongress < MiniTest::Unit::TestCase
  ['chamber', 'committee_id', 'name', 'parent_committee_id', 'subcommittee'].each do |attr|
    define_method "test_#{attr}" do
      l = Sunlight::Congress::Committee.new(attr => "foo")

      assert_equal "foo", l.send(attr)
    end
  end
end
