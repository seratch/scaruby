# -*- encoding: utf-8 -*-

require 'scaruby'

describe Option do
  it 'has self.new' do
    some = Option.new(123)
    some.is_defined.should eq(true)
    some.is_empty.should eq(false)
  end
  it 'has #get and the method works with Some' do
    some = Option.new(123)
    some.get.should eq(123)
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
    some.get_or_else(999).should eq(123)
  end
  it 'has #get_or_else and the method works with None' do
    none = Option.new(nil)
    none.get_or_else(999).should eq(999)
  end
  it 'has #map and the method works with Some' do
    some = Option.new(123)
    some_result = some.map { |v| v + v }
    some_result.get_or_else(999).should eq(246)
  end
  it 'has #map and the method works with None' do
    none = Option.new(nil)
    none_result = none.map { |v| v + v }
    none_result.get_or_else(999).should eq(999)
  end
  it 'has #fold and the method works with Some' do
    some = Option.new(123)
    some.fold(999){ |v| v +v }.should eq(246)
  end
  it 'has #fold and the method works with None' do
    none = Option.new(nil)
    none.fold(999){ |v| v +v }.should eq(999)
  end
end

