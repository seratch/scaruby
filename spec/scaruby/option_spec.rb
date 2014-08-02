# -*- encoding: utf-8 -*-

require 'scaruby'

describe Option do
  it 'has self.new' do
    some = Option.new(123)
    expect(some.is_defined).to be_truthy
    expect(some.is_empty).to be_falsey
  end
  it 'has #get and the method works with Some' do
    some = Option.new(123)
    expect(some.get).to eq(123)
  end
  it 'has #get and the method works with None' do
    none = Option.new(nil)
    begin
      none.get
      violated "NoSuchElementException should be thorwn!"
    rescue Scaruby::NoSuchElementException => e
    end
  end
  it 'has #get_or_else and the method works with Some' do
    some = Option.new(123)
    expect(some.get_or_else(999)).to eq(123)
  end
  it 'has #get_or_else and the method works with None' do
    none = Option.new(nil)
    expect(none.get_or_else(999)).to eq(999)
  end
  it 'has #map and the method works with Some' do
    some = Option.new(123)
    some_result = some.map { |v| v + v }
    expect(some_result.get_or_else(999)).to eq(246)
  end
  it 'has #map and the method works with None' do
    none = Option.new(nil)
    none_result = none.map { |v| v + v }
    expect(none_result.get_or_else(999)).to eq(999)
  end
  it 'has #fold and the method works with Some' do
    some = Option.new(123)
    expect(some.fold(999){ |v| v +v }).to eq(246)
  end
  it 'has #fold and the method works with None' do
    none = Option.new(nil)
    expect(none.fold(999){ |v| v +v }).to eq(999)
  end
end

