# -*- encoding: utf-8 -*-

require 'enumerable_to_scaruby'

describe Enumerable do
  it 'has #count' do
    [1,2,3,4,5].count {|i| i > 2 }.should eq(3)
  end
  it 'has #diff' do
    [1,2,3].diff([2,3,4]).to_a.should eq([1])
  end
  it 'has #distinct' do
    [1,2,4,1,3,3,3,2,4,1].distinct.to_a.should eq([1,2,4,3])
  end
  it 'has #drop_right' do
    1.upto(5).drop_right(3).to_a.should eq([1,2])
  end
  it 'has #drop_while' do
    [1,2,4,3,5].drop_while {|i| i < 3 }.to_a.should eq([4,3,5])
  end
  it 'has #ends_with' do
    1.upto(5).ends_with([4,5]).should eq(true)
  end
  it 'has #exists' do
    1.upto(5).exists {|i| i == 2 }.should eq(true)
  end
  it 'has #filter' do
    1.upto(5).filter {|i| i < 3 }.to_a.should eq([1,2])
  end
  it 'has #filter_not' do
    1.upto(5).filter_not {|i| i < 3 }.to_a.should eq([3,4,5])
  end
  it 'has #flat_map' do
    flatten = [[1,2],[3],[4,5]].flat_map {|i| i }.to_a
    flatten.should eq([1,2,3,4,5])
  end
  it 'has #flatten' do
    [[1,2,3],[4,5],[6]].flatten.to_a.should eq([1,2,3,4,5,6])
  end
  it 'has #fold_left' do
    1.upto(5).fold_left(0) {|z,x| z + x }.should eq(15)
  end
  it 'has #forall' do
    1.upto(5).forall {|i| i < 10 }.should eq(true)
  end
  it 'has #foreach' do
    1.upto(5).foreach do |i|
      i.should <= 5
    end
  end
  it 'has #head' do
    1.upto(5).head.should eq(1)
  end
  it 'has #head_option' do
    1.upto(5).head_option.is_defined.should eq(true)
  end
end

