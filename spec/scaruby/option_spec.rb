#encoding: UTF-8

require 'scaruby/option'
require 'scaruby/no_such_element_exception'

describe Scaruby::Option do
  it 'has self.new' do
    some = Scaruby::Option.new(123)
    some.is_defined.should eq(true)
  end 
  it 'has #get and it works with Some' do
    some = Scaruby::Option.new(123)
    some.get.should eq(123)
  end
  it 'has #get and it works with None' do
    none = Scaruby::Option.new(nil)
    begin
      none.get
      violated "NoSuchElementException should be thorwn!"
    rescue Scaruby::NoSuchElementException => e
    end
  end
  it 'has #get_or_else and it works with Some' do
    some = Scaruby::Option.new(123)
    some.get_or_else(999).should eq(123)
  end
  it 'has #get_or_else and it works with None' do
    none = Scaruby::Option.new(nil)
    none.get_or_else(999).should eq(999)
  end
  it 'has #map and it works with Some' do
    some = Scaruby::Option.new(123)
    some_result = some.map {|v| v + v }
    some_result.get_or_else(999).should eq(246)
  end 
  it 'has #map and it works with None' do
    none = Scaruby::Option.new(nil)
    none_result = none.map {|v| v + v }
    none_result.get_or_else(999).should eq(999)
  end
end



