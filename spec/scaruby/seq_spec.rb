#encoding: UTF-8

require 'array_to_scaruby'
require 'scaruby/seq'

describe Scaruby::Seq do
  one_to_five = [1,2,3,4,5]
  one_to_five_shuffled = one_to_five.sort_by {rand}
  it 'has #to_a' do
    array = Scaruby::Seq.new(one_to_five).to_a
    array.should eq([1,2,3,4,5])
  end
  it 'has #count' do
    result = Scaruby::Seq.new(one_to_five).count {|i| i > 2 }
    result.should eq(3)
  end
  it 'has #diff' do
    result = Scaruby::Seq.new([1,2,3]).diff([2,3,4]).to_a
    result.should eq([1])
  end
  it 'has #distinct' do
    result = Scaruby::Seq.new([1,2,4,1,3,3,3,2,4,1]).distinct.to_a
    result.should eq([1,2,4,3])
  end
  it 'has #drop' do
    result = Scaruby::Seq.new(one_to_five).drop(3).to_a
    result.should eq([4,5])
    result = Scaruby::Seq.new(one_to_five).drop(7).to_a
    result.should eq([])
  end
  it 'has #drop_right' do
    result = Scaruby::Seq.new(one_to_five).drop_right(3).to_a
    result.should eq([1,2])
    result = Scaruby::Seq.new(one_to_five).drop_right(7).to_a
    result.should eq([])
  end
  it 'has #drop_while' do
    result = Scaruby::Seq.new([5,3,2,4,1]).drop_while {|e| e > 2 }.to_a
    result.should eq([5,3])
  end
  it 'has #ends_with' do
  end
  it 'has #exists' do
  end
  it 'has #filter' do
    result = Scaruby::Seq.new(one_to_five).filter {|i| i > 3 }.to_a
    result.should eq([4,5])
  end
  it 'has #filter_not' do
  end
  it 'has #find' do
  end
  it 'has #flat_map and it works with nested arrays' do
    result = Scaruby::Seq.new([[1,2],[3,4],[5]]).flat_map {|i| i }.to_a
    result.should eq([1,2,3,4,5])
  end
  it 'has #flat_map and it works with Option elements' do
    result = Scaruby::Seq.new([1,2,nil,3]).flat_map {|i| Scaruby::Option.new(i) }.to_a
    result.should eq([1,2,3])
  end
  it 'has #fold_left' do
    result = Scaruby::Seq.new(one_to_five_shuffled).fold_left(0) {|z,x| z + x }
    result.should eq(15)
  end
  it 'has #flatten' do
  end
  it 'has #forall' do
  end
  it 'has #foreach' do
  end
  it 'has #group_by' do
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
  it 'has #indices' do
  end
  it 'has #init' do
  end
  it 'has #intersect' do
  end
  it 'has #is_empty' do
  end
  it 'has #last' do
  end
  it 'has #last_option' do
  end
  it 'has #lift' do
  end
  it 'has #map' do
    result = Scaruby::Seq.new([1,2,3]).map {|i| i + i }.to_a
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
  it 'has #mk_string' do
  end
  it 'has #non_empty' do
  end
  it 'has #par' do
  end
  it 'has #partition' do
  end
  it 'has #patch' do
  end
  it 'has #reduce_left' do
  end
  it 'has #reduce_right' do
  end
  it 'has #reverse' do
  end
  it 'has #reverse_iterator' do
  end
  it 'has #reverse_map' do
  end
  it 'has #same_elements' do
  end
  it 'has #scan' do
  end
  it 'has #scan_left' do
  end
  it 'has #scan_right' do
  end
  it 'has #slice' do
  end
  it 'has #sliding' do
  end
  it 'has #sort_by' do
  end
  it 'has #sort_with' do
  end
  it 'has #span' do
  end
  it 'has #split_at' do
  end
  it 'has #starts_with' do
  end
  it 'has #sum' do
  end
  it 'has #tail' do
  end
  it 'has #take' do
  end
  it 'has #take_right' do
  end
  it 'has #take_while' do
  end
  it 'has #union' do
  end
  it 'has #unzip' do
  end
  it 'has #updated' do
  end
  it 'has #zip' do
  end
  it 'has #zip_all' do
  end
  it 'has #zip_with_index' do
  end
end




