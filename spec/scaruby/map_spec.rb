# -*- encoding: utf-8 -*-

require 'scaruby'

describe Map do

  hash = {123 => 'abc', 234 => 'bcd', 345 => 'cde', 4 => 'd', 56 => 'ef', 7 => 'g', 89 => 'hi' }

  it 'has self.new' do
    map = Map.new({1 => 'a', 2 => 'b'})
    map.should_not eq(nil)
  end 
  it 'has #contains' do
    Map.new(hash).contains(123).should eq(true)
    Map.new(hash).contains(999).should eq(false)
  end
  it 'has #count' do
    Map.new(hash).count {|k,v| k.to_s.length >= 2 }.should eq(5)
  end
  it 'hash Map.empty' do
    Map.empty.should eq({})
  end
  it 'has #exists' do
    Map.new(hash).exists {|k,v| k.to_s.length == 1 }.should eq(true)
  end
  it 'has #filter' do
    Map.new(hash).filter {|k,v| k.to_s.length < 3 }.to_hash.size.should eq(4)
  end
  it 'has #filter_keys' do
    Map.new(hash).filter_keys {|k| k.to_s.length < 3 }.to_hash.size.should eq(4)
  end
  it 'has #filter_not' do
    Map.new(hash).filter_not {|k| k.to_s.length < 3 }.to_hash.to_s.should eq('{123=>"abc", 234=>"bcd", 345=>"cde"}')
  end
  it 'has #find' do
    Map.new(hash).find {|k,v| k.to_s.length == 2 }.get[1].should eq('ef')
  end
  it 'has #forall' do
    Map.new(hash).forall {|k,v| k.to_s.length <= 3 }.should eq(true)
    Map.new(hash).forall {|k,v| k.to_s.length >= 2 }.should eq(false)
  end
  it 'has #foreach' do
    Map.new(hash).foreach do |k,v| 
      hash.include?(k).should eq(true)
    end
  end
  it 'has #get_or_else' do
    Map.new(hash).get_or_else(123, 'xxx').should eq('abc')
    Map.new(hash).get_or_else(999, 'xxx').should eq('xxx')
  end
  it 'has #is_empty' do
    Map.new(hash).is_empty.should eq(false)
    Map.new({}).is_empty.should eq(true)
    Map.new(nil).is_empty.should eq(true)
  end
  it 'has #key_set' do
    Map.new(hash).key_set.should eq(hash.keys)
  end
  it 'has #lift' do
    lifted = Map.new(hash).lift
    lifted.apply(123).get.should eq('abc')
    lifted.apply(999).is_defined.should eq(false)
    lifted.call(123).get.should eq('abc')
    lifted.call(999).is_defined.should eq(false)
  end
  it 'has #map' do
    new_map = Map.new(hash).map {|k,v| [k+k,v] }.to_hash
    new_map.include?(246).should eq(true)
  end
  it 'has #minus' do
    Map.new(hash).minus(123,234,345).to_hash.should eq({4=>'d',56=>'ef',7=>'g',89=>'hi'})
  end
  it 'has #mk_string' do
    Map.new(hash).mk_string().should eq('{123=>abc, 234=>bcd, 345=>cde, 4=>d, 56=>ef, 7=>g, 89=>hi}')
  end
  it 'has #non_empty' do
    Map.new(hash).non_empty.should eq(true)
    Map.new({}).non_empty.should eq(false)
    Map.new(nil).non_empty.should eq(false)
  end
  it 'has #plus' do
    Map.new({123=>'abc',234=>'bcd'}).plus([[345,'cde']]).to_hash.should eq({123=>'abc',234=>'bcd',345=>'cde'})
  end
  it 'has #updated' do
    Map.new({123=>'abc',234=>'bcd'}).updated(345,'cde').to_hash.should eq({123=>'abc',234=>'bcd',345=>'cde'})
  end
  it 'has #unzip' do
    unzipped = Map.new({123=>'abc',234=>'bcd'}).unzip.to_a
    unzipped[0].should eq([123,234])
    unzipped[1].should eq(['abc','bcd'])
  end
end

