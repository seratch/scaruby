# -*- encoding: utf-8 -*-

require 'scaruby'

describe Scaruby do
  it 'has converter' do
    [1,2,3].to_scaruby.should_not eq(nil)
  end
end

