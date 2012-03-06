# -*- encoding: utf-8 -*-

require 'scaruby'

describe Scaruby do
  it 'has assertion' do
    assert('1' != 1)
    begin
      assert('1' == 1)
      raise 'Expected exception did not occurred'
    rescue AssertionError => e
    end
  end
  it 'has converter' do
    [1,2,3].to_scaruby.should_not eq(nil)
  end
end

