# -*- encoding: utf-8 -*-

require 'scaruby'

describe Map do

  hash = {123 => 'abc', 234 => 'bcd', 345 => 'cde', 4 => 'd', 56 => 'ef', 7 => 'g', 89 => 'hi'}

  it 'does not accept invalid args' do
    begin
      map = Map.new(1234)
      raise 'Expected exception did not be raised!'
    rescue AssertionError
    end
  end

  it 'has self.new' do
    map = Map.new({1 => 'a', 2 => 'b'})
    expect(map).not_to eq(nil)
  end

  # as a sub type of Hash
  it 'has #each' do
    expected_key = 1
    expected_value = 10
    returned = Map.new({1 => 10, 2 => 20}).each do |k, v|
      expect(k).to eq(expected_key)
      expect(v).to eq(expected_value)
      expected_key += 1
      expected_value += 10
    end
    expect(returned).to eq(nil)
  end

  # defined
  it 'has #contains' do
    expect(Map.new(hash).contains(123)).to be_truthy
    expect(Map.new(hash).contains(999)).to be_falsey
  end
  it 'has #count' do
    expect(Map.new(hash).count { |k, v| k.to_s.length >= 2 }).to eq(5)
  end
  it 'hash Map.empty' do
    expect(Map.empty).to eq({})
  end
  it 'has #exists' do
    expect(Map.new(hash).exists { |k, v| k.to_s.length == 1 }).to be_truthy
  end
  it 'has #filter' do
    expect(Map.new(hash).filter { |k, v| k.to_s.length < 3 }.to_hash.size).to eq(4)
  end
  it 'has #filter_keys' do
    expect(Map.new(hash).filter_keys { |k| k.to_s.length < 3 }.to_hash.size).to eq(4)
  end
  it 'has #filter_not' do
    expect(Map.new(hash).filter_not { |k, v| k.to_s.length < 3 }.to_hash.to_s).to eq('{123=>"abc", 234=>"bcd", 345=>"cde"}')
  end
  it 'has #find' do
    expect(Map.new(hash).find { |k, v| k.to_s.length == 2 }.get[1]).to eq('ef')
  end
  it 'has #forall' do
    expect(Map.new(hash).forall { |k, v| k.to_s.length <= 3 }).to be_truthy
    expect(Map.new(hash).forall { |k, v| k.to_s.length >= 2 }).to be_falsey
  end
  it 'has #foreach' do
    returned = Map.new(hash).foreach do |k, v|
      expect(hash.include?(k)).to be_truthy
    end
    expect(returned).to eq(nil)
  end
  it 'has #get_or_else' do
    expect(Map.new(hash).get_or_else(123, 'xxx')).to eq('abc')
    expect(Map.new(hash).get_or_else(999, 'xxx')).to eq('xxx')
  end
  it 'has #is_empty' do
    expect(Map.new(hash).is_empty).to be_falsey
    expect(Map.new({}).is_empty).to be_truthy
    expect(Map.new(nil).is_empty).to be_truthy
  end
  it 'has #key_set' do
    expect(Map.new(hash).key_set).to eq(hash.keys)
  end
  it 'has #lift' do
    lifted = Map.new(hash).lift
    expect(lifted.apply(123).get).to eq('abc')
    expect(lifted.apply(999).is_defined).to be_falsey
    expect(lifted.call(123).get).to eq('abc')
    expect(lifted.call(999).is_defined).to be_falsey
  end
  it 'has #map' do
    new_map = Map.new(hash).map { |k, v| [k+k, v] }.to_hash
    expect(new_map.include?(246)).to be_truthy
  end
  it 'has #minus' do
    expect(Map.new(hash).minus(123, 234, 345).to_hash).to eq({4 => 'd', 56 => 'ef', 7 => 'g', 89 => 'hi'})
  end
  it 'has #mk_string' do
    expect(Map.new(hash).mk_string()).to eq('{123=>abc, 234=>bcd, 345=>cde, 4=>d, 56=>ef, 7=>g, 89=>hi}')
  end
  it 'has #non_empty' do
    expect(Map.new(hash).non_empty).to be_truthy
    expect(Map.new({}).non_empty).to be_falsey
    expect(Map.new(nil).non_empty).to be_falsey
  end
  it 'has #plus' do
    expect(Map.new({123 => 'abc', 234 => 'bcd'}).plus([[345, 'cde']]).to_hash).to eq({123 => 'abc', 234 => 'bcd', 345 => 'cde'})
  end
  it 'has #updated' do
    expect(Map.new({123 => 'abc', 234 => 'bcd'}).updated(345, 'cde').to_hash).to eq({123 => 'abc', 234 => 'bcd', 345 => 'cde'})
  end
  it 'has #unzip' do
    unzipped = Map.new({123 => 'abc', 234 => 'bcd'}).unzip.to_a
    expect(unzipped[0]).to eq([123, 234])
    expect(unzipped[1]).to eq(['abc', 'bcd'])
  end
end

