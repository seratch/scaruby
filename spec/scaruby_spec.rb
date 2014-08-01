# -*- encoding: utf-8 -*-

require 'scaruby'

describe Scaruby do
  it 'has assert_type' do
    assert_type(123, Fixnum)
    assert_type(123, String, Fixnum, Hash)
    begin
      assert_type(123, Hash, Array)
      raise 'Expected exception did not be raised!'
    rescue AssertionError => e
      expect(e.message).to eq('The type of `123` should be whichever of [Hash, Array] but actually Fixnum.')
    end
    assert_type([1, 2, 3], Array)
    assert_type({1 => 'a'}, Hash)
    assert_type(nil, Array)
    assert_type(nil, Hash)
  end
  it 'has assert' do
    assert('1' != 1)
    begin
      assert('1' == 1)
      raise 'Expected exception did not be raised!'
    rescue AssertionError => e
    end
  end
  it 'has converter' do
    expect([1, 2, 3].to_scaruby).not_to eq(nil)
  end
end

