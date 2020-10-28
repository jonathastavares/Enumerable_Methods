# ./spec/my_enumerable.rb
require_relative '../lib/my_enumerable.rb'

#describe Enumerable do
  #let(:array) { [1, 2, 3, 4, 5] }
  #let(:mixed_val) { [1, 2, 3, 4, 'a'] }
  #let(:string_val) { %w[ant bear cat] }
  #let(:float_val) { [1, 3.14, 42] }
  #let(:nil_false_array) { [nil, false] }
  #let(:hash) { { 'color' => '#fff', 'font_family' => 'Arial' } }

  describe `my_each` do
    it 'returns the length of the array' do
      array = [1, 2, 3, 4, 5]
      expect(my_each {array}).to eql(5)
    end
  end
#end
