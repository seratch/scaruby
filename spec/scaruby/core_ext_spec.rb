# -*- encoding: utf-8 -*-

require 'scaruby/core_ext'

describe Enumerable do
  it 'has #count' do
    [1,2,3,4,5].count {|i| i > 2 }.should eq(3)
  end
  it 'has #diff' do
    [1,2,3].diff([2,3,4]).should eq([1])
  end
  it 'has #distinct' do
    [1,2,4,1,3,3,3,2,4,1].distinct.should eq([1,2,4,3])
  end
  it 'has #drop_right' do
    1.upto(5).drop_right(3).should eq([1,2])
  end
  it 'has #drop_while' do
    [1,2,4,3,5].drop_while {|i| i < 3 }.should eq([4,3,5])
  end
  it 'has #ends_with' do
    1.upto(5).ends_with([4,5]).should eq(true)
  end
  it 'has #exists' do
    1.upto(5).exists {|i| i == 2 }.should eq(true)
  end
  it 'has #filter' do
    1.upto(5).filter {|i| i < 3 }.should eq([1,2])
  end
  it 'has #filter_not' do
    1.upto(5).filter_not {|i| i < 3 }.should eq([3,4,5])
  end
  it 'has #flat_map' do
    flatten = [[1,2],[3],[4,5]].flat_map {|i| i }
    flatten.should eq([1,2,3,4,5])
  end
  it 'has #flatten' do
    [[1,2,3],[4,5],[6]].flatten.should eq([1,2,3,4,5,6])
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

describe Hash do

  hash = {123 => 'abc', 234 => 'bcd', 345 => 'cde', 4 => 'd', 56 => 'ef', 7 => 'g', 89 => 'hi' }

  it 'has #contains' do
    hash.contains(123).should eq(true)
    hash.contains(999).should eq(false)
  end
  it 'has #count' do
    hash.count {|k,v| k.to_s.length >= 2 }.should eq(5)
  end
  it 'hash Map.empty' do
    Map.empty.should eq({})
  end
  it 'has #exists' do
    hash.exists {|k,v| k.to_s.length == 1 }.should eq(true)
  end
  it 'has #filter' do
    hash.filter {|k,v| k.to_s.length < 3 }.to_hash.size.should eq(4)
  end
  it 'has #filter_keys' do
    hash.filter_keys {|k| k.to_s.length < 3 }.to_hash.size.should eq(4)
  end
  it 'has #filter_not' do
    hash.filter_not {|k| k.to_s.length < 3 }.to_hash.to_s.should eq('{123=>"abc", 234=>"bcd", 345=>"cde"}')
  end
  it 'has #find' do
    #hash.find {|k,v| k.to_s.length == 2 }.get[1].should eq('ef')
    hash.find {|k,v| k.to_s.length == 2 }[1].should eq('ef')
  end
  it 'has #forall' do
    hash.forall {|k,v| k.to_s.length <= 3 }.should eq(true)
    hash.forall {|k,v| k.to_s.length >= 2 }.should eq(false)
  end
  it 'has #foreach' do
    hash.foreach do |k,v| 
      hash.include?(k).should eq(true)
    end
  end
  it 'has #get_or_else' do
    hash.get_or_else(123, 'xxx').should eq('abc')
    hash.get_or_else(999, 'xxx').should eq('xxx')
  end
  it 'has #is_empty' do
    hash.is_empty.should eq(false)
    Map.new({}).is_empty.should eq(true)
    Map.new(nil).is_empty.should eq(true)
  end
  it 'has #key_set' do
    hash.key_set.should eq(hash.keys)
  end
  it 'has #lift' do
    lifted = hash.lift
    lifted.apply(123).get.should eq('abc')
    lifted.apply(999).is_defined.should eq(false)
  end
end
