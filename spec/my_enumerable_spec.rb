# ./spec/my_enumerable_spec.rb
# rubocop:disable Style/SymbolProc

require_relative '../lib/my_enumerable.rb'

describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:string_val) { %w[ant bear cat] }
  let(:nil_false_array) { [nil, false] }
  let(:count_array) { [1, 2, 4, 2] }

  describe 'my_each' do
    it 'returns each item of the array' do
      result = []
      array.my_each { |item| result << item + 1 }
      expect(result).to eq([2, 3, 4, 5, 6])
    end

    it 'returns nothing if no block is given' do
      result = []
      array.my_each
      expect(result).to eq([])
    end
  end

  describe 'my_each_with_index' do
    it 'returns each item of the array' do
      result = []
      array.my_each_with_index { |item| result << item + 1 }
      expect(result).to eq([2, 3, 4, 5, 6])
    end

    it 'returns nothing if no block is given' do
      result = []
      array.my_each_with_index
      expect(result).to eq([])
    end
  end

  describe 'my_select' do
    it 'returns the element if condition is reached' do
      result = []
      array.my_select { |x| result << x if x.even? }
      expect(result).to eq([2, 4])
    end

    it 'returns nothing if no block is given' do
      result = []
      array.my_select
      expect(result).to eq([])
    end
  end

  describe 'my_all?' do
    it 'returns true if all array elements have the same type' do
      expect(string_val.my_all?).to eq(true)
    end

    it 'it returns false if any element of the array is nil or false' do
      expect(nil_false_array.my_all?).to eq(false)
    end
  end

  describe 'my_any?' do
    it 'returns true if any element in the array reaches the condition' do
      expect(string_val.my_any? { |word| word.length >= 3 }).to eq(true)
    end

    it 'returns false if array is empty' do
      expect([].my_any?).to eq(false)
    end
  end

  describe 'my_none?' do
    it 'Returns true if none of the elements in the array reaches the condition' do
      expect(string_val.my_none? { |word| word.length == 5 }).to eq(true)
    end

    it 'Returns true if any of the elements in the array reaches the condition' do
      expect(string_val.my_none? { |word| word.length >= 4 }).to eq(false)
    end
  end

  describe 'my_count' do
    it 'Returns the length of the array if no condition was given' do
      expect(count_array.my_count).to eq(4)
    end

    it 'Returns the number of times the condition appears in the array' do
      expect(count_array.my_count(2)).to eq(2)
    end

    it 'Returns the number of time the condition was reached by the elements in the array' do
      expect(count_array.my_count { |x| x.even? }).to eq(3)
    end
  end

  describe 'my_map' do
    it 'Returns a new array with the results of running block once for every element in enum.' do
      expect(array.my_map { |x| x * 3 }).to eq([3, 6, 9, 12, 15])
    end

    it 'Returns a new array with the results of running block once for every element in enum.' do
      expect(array.my_map).to be_an(Enumerator)
    end
  end

  describe 'my_inject' do
    it 'Multiply the elements of the array' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eq(151_200)
    end

    it 'Adds the elements of the array' do
      expect((5..10).reduce(:+)).to eq(45)
    end

    longest = %w[ant bear cat].my_inject do |memo, word|
      memo.length > word.length ? memo : word
    end
    it 'Returns the longest word in the array' do
      expect(longest).to eq('bear')
    end
  end
end
# rubocop:enable Style/SymbolProc
