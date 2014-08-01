# -*- encoding: utf-8 -*-

require 'scaruby/core_ext'

describe Hash do

  hash = {123 => 'abc', 234 => 'bcd', 345 => 'cde', 4 => 'd', 56 => 'ef', 7 => 'g', 89 => 'hi'}

  it 'has #contains' do
    expect(hash.contains(123)).to eq(true)
    expect(hash.contains(999)).to eq(false)
  end
  it 'has #count' do
    expect(hash.count { |k, v| k.to_s.length >= 2 }).to eq(5)
  end
  it 'hash Map.empty' do
    expect(Map.empty).to eq({})
  end
  it 'has #exists' do
    expect(hash.exists { |k, v| k.to_s.length == 1 }).to eq(true)
  end
  it 'has #filter' do
    expect(hash.filter { |k, v| k.to_s.length < 3 }.to_hash.size).to eq(4)
  end
  it 'has #filter_keys' do
    expect(hash.filter_keys { |k| k.to_s.length < 3 }.to_hash.size).to eq(4)
  end
  it 'has #filter_not' do
    expect(hash.filter_not { |k, v| k.to_s.length < 3 }.to_hash.to_s).to eq('{123=>"abc", 234=>"bcd", 345=>"cde"}')
  end
  it 'has #find' do
    # the already defined method is called
    #hash.find {|k,v| k.to_s.length == 2 }.get[1].should eq('ef')
    expect(hash.find { |k, v| k.to_s.length == 2 }[1]).to eq('ef')
  end
  it 'has #forall' do
    expect(hash.forall { |k, v| k.to_s.length <= 3 }).to eq(true)
    expect(hash.forall { |k, v| k.to_s.length >= 2 }).to eq(false)
  end
  it 'has #foreach' do
    hash.foreach do |k, v|
      expect(hash.include?(k)).to eq(true)
    end
  end
  it 'has #get_or_else' do
    expect(hash.get_or_else(123, 'xxx')).to eq('abc')
    expect(hash.get_or_else(999, 'xxx')).to eq('xxx')
  end
  it 'has #is_empty' do
    expect(hash.is_empty).to eq(false)
    expect({}.is_empty).to eq(true)
  end
  it 'has #key_set' do
    expect(hash.key_set).to eq(hash.keys)
  end
  it 'has #lift' do
    lifted = hash.lift
    expect(lifted.apply(123).get).to eq('abc')
    expect(lifted.apply(999).is_defined).to eq(false)
    expect(lifted.call(123).get).to eq('abc')
    expect(lifted.call(999).is_defined).to eq(false)
  end
  it 'has #map' do
    # the already defined method is called
    #new_map = hash.map {|k,v| [k+k,v] }.to_hash
    #new_map.include?(246).should eq(true)
    seq = hash.map { |k, v| [k+k, v] }
    expect(seq.include?([246, 'abc'])).to eq(true)
  end
  it 'has #minus' do
    expect(hash.minus(123, 234, 345).to_hash).to eq({4 => 'd', 56 => 'ef', 7 => 'g', 89 => 'hi'})
  end
  it 'has #mk_string' do
    expect(hash.mk_string()).to eq('{123=>abc, 234=>bcd, 345=>cde, 4=>d, 56=>ef, 7=>g, 89=>hi}')
  end
  it 'has #non_empty' do
    expect(hash.non_empty).to eq(true)
    expect({}.non_empty).to eq(false)
  end
  it 'has #plus' do
    expect({123 => 'abc', 234 => 'bcd'}.plus([[345, 'cde']]).to_hash).to eq({123 => 'abc', 234 => 'bcd', 345 => 'cde'})
  end
  it 'has #updated' do
    expect({123 => 'abc', 234 => 'bcd'}.updated(345, 'cde').to_hash).to eq({123 => 'abc', 234 => 'bcd', 345 => 'cde'})
  end
  it 'has #unzip' do
    unzipped = {123 => 'abc', 234 => 'bcd'}.unzip.to_a
    expect(unzipped[0]).to eq([123, 234])
    expect(unzipped[1]).to eq(['abc', 'bcd'])
  end
end

