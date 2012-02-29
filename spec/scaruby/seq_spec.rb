#encoding: UTF-8

require 'scaruby/seq'

describe Scaruby::Seq do
  one_to_five = [1,2,3,4,5]
  one_to_five_shuffled = one_to_five.sort_by {rand}
  it 'has #count' do
    result = Scaruby::Seq.new(one_to_five).count {|i| i > 2 }
    result.should eq(3)
  end
  it 'has #diff' do
    result = Scaruby::Seq.new([1,2,3]).diff([2,3,4])
    result.should eq([1])
  end
  it 'has #distinct' do
    result = Scaruby::Seq.new([1,2,4,1,3,3,3,2,4,1]).distinct
    result.should eq([1,2,4,3])
  end
  it 'has #drop' do
    result = Scaruby::Seq.new(one_to_five).drop(3)
    result.should eq([4,5])
    result = Scaruby::Seq.new(one_to_five).drop(7)
    result.should eq([])
  end
  it 'has #drop_right' do
    result = Scaruby::Seq.new(one_to_five).drop_right(3)
    result.should eq([1,2])
    result = Scaruby::Seq.new(one_to_five).drop_right(7)
    result.should eq([])
  end
  it 'has #drop_while' do
    result = Scaruby::Seq.new([5,3,2,4,1]).drop_while {|e| e > 2 }
    result.should eq([5,3])
  end
  it 'has #filter' do
    result = Scaruby::Seq.new(one_to_five).filter {|i| i > 3 }
    result.should eq([4,5])
  end
  it 'has #flat_map and it works with nested arrays' do
    result = Scaruby::Seq.new([[1,2],[3,4],[5]]).flat_map {|i| i }
    result.should eq([1,2,3,4,5])
  end
  it 'has #flat_map and it works with Option elements' do
    result = Scaruby::Seq.new([1,2,nil,3]).flat_map {|i| Scaruby::Option.new(i) }
    result.should eq([1,2,3])
  end
  it 'has #fold_left' do
    result = Scaruby::Seq.new(one_to_five_shuffled).fold_left(0) {|z,x| z + x }
    result.should eq(15)
  end
  it 'has #head' do
    result = Scaruby::Seq.new(one_to_five).head
    result.should eq(1)
  end
  it 'has #head_option and it works with Some' do
    some = Scaruby::Seq.new(one_to_five).head_option
    some.get_or_else(999).should eq(1)
  end
  it 'has #head_option and it works with None' do
    none = Scaruby::Seq.new([]).head_option
    none.get_or_else(999).should eq(999)
  end
  it 'has #map' do
    result = Scaruby::Seq.new([1,2,3]).map {|i| i + i }
    result.should eq([2,4,6])
  end
  it 'has #max' do
    result = Scaruby::Seq.new(one_to_five_shuffled).max
    result.should eq(5)
  end
  it 'has #min' do
    result = Scaruby::Seq.new(one_to_five_shuffled).min
    result.should eq(1)
  end
end




