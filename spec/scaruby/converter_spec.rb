# -*- encoding: utf-8 -*-

require 'scaruby/converter'

describe Enumerable do
  it 'has #to_scaruby' do
    expect([1, 2, 3].to_scaruby.filter { |e| e > 1 }.to_a).to eq([2, 3])
  end
end

describe Hash do
  it 'has #to_scaruby' do
    expect({123 => 'abc', 2 => 'b', 34 => 'cd'}.to_scaruby.filter { |k, v|
      k.to_s.length == 1
    }.to_hash).to eq({2 => 'b'})
  end
end

describe Object do
  it 'has #to_option' do
    expect('abc'.to_option.is_defined).to eq(true)
    expect('abc'.to_option.get_or_else('zzz')).to eq('abc')
    expect(nil.to_option.is_defined).to eq(false)
    expect(nil.to_option.get_or_else('zzz')).to eq('zzz')
  end
end

