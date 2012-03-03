# -*- encoding: utf-8 -*-

require 'scaruby/converter'

describe Enumerable do
  it 'has #to_scaruby' do
    [1,2,3].to_scaruby.filter {|e| e > 1 }.to_a.should eq([2,3])
  end
end

describe Hash do
  it 'has #to_scaruby' do
    {123=>'abc',2=>'b',34=>'cd'}.to_scaruby.filter {|k,v| 
      k.to_s.length == 1
    }.to_hash.should eq({2=>'b'})
  end
end

describe Object do
  it 'has #to_option' do
    'abc'.to_option.is_defined.should eq(true)
    'abc'.to_option.get_or_else('zzz').should eq('abc')
    nil.to_option.is_defined.should eq(false)
    nil.to_option.get_or_else('zzz').should eq('zzz')
  end
end

