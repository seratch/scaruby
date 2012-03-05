# -*- encoding: utf-8 -*-

require 'scaruby/core_ext'

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
    hash.filter_not {|k,v| k.to_s.length < 3 }.to_hash.to_s.should eq('{123=>"abc", 234=>"bcd", 345=>"cde"}')
  end
  it 'has #find' do
    # the already defined method is called
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
    {}.is_empty.should eq(true)
  end
  it 'has #key_set' do
    hash.key_set.should eq(hash.keys)
  end
  it 'has #lift' do
    lifted = hash.lift
    lifted.apply(123).get.should eq('abc')
    lifted.apply(999).is_defined.should eq(false)
    lifted.call(123).get.should eq('abc')
    lifted.call(999).is_defined.should eq(false)
  end
  it 'has #map' do
    # the already defined method is called
    #new_map = hash.map {|k,v| [k+k,v] }.to_hash
    #new_map.include?(246).should eq(true)
    seq = hash.map {|k,v| [k+k,v] }
    seq.include?([246,'abc']).should eq(true)
  end
  it 'has #minus' do
    hash.minus(123,234,345).to_hash.should eq({4=>'d',56=>'ef',7=>'g',89=>'hi'})
  end
  it 'has #mk_string' do
    hash.mk_string().should eq('{123=>abc, 234=>bcd, 345=>cde, 4=>d, 56=>ef, 7=>g, 89=>hi}')
  end
  it 'has #non_empty' do
    hash.non_empty.should eq(true)
    {}.non_empty.should eq(false)
  end
  it 'has #plus' do
    {123=>'abc',234=>'bcd'}.plus([[345,'cde']]).to_hash.should eq({123=>'abc',234=>'bcd',345=>'cde'})
  end
  it 'has #updated' do
    {123=>'abc',234=>'bcd'}.updated(345,'cde').to_hash.should eq({123=>'abc',234=>'bcd',345=>'cde'})
  end
  it 'has #unzip' do
    unzipped = {123=>'abc',234=>'bcd'}.unzip.to_a
    unzipped[0].should eq([123,234])
    unzipped[1].should eq(['abc','bcd'])
  end
end

