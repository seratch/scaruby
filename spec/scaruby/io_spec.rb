# -*- encoding: utf-8 -*-

require 'scaruby'

describe Scaruby::IO::Source do

  http_url = 'http://seratch.github.com/'
  https_url = 'https://github.com/seratch/scaruby'

  it 'has from_file' do
    file = 'spec/scaruby_spec.rb'
    source = Source.from_file(file)
    source.to_seq.foreach do |c|
      line.is_a?(String).should eq(true)
    end
    lines = source.get_lines
    lines.is_a?(Enumerable).should eq(true)
    lines.foreach do |line|
      line.is_a?(String).should eq(true)
    end
  end
  it 'has from_bytes' do
    str = 'zzz 日本語を含む文字列 999'
    bytes = str.bytes.to_a
    source = Source.from_bytes(bytes)
    source.to_seq.foreach do |c|
      c.is_a?(String).should eq(true)
    end
    source.get_lines.mk_string.should eq(str)
  end
  it 'has from_url with a http url' do
    source = Source.from_url(http_url)
    source.to_seq.foreach do |c|
      c.is_a?(String).should eq(true)
    end
  end
  it 'has from_url with a https url' do
    source = Source.from_url(https_url)
    source.to_seq.foreach do |c|
      c.is_a?(String).should eq(true)
    end
  end
  it 'has #get_lines' do
    source = Source.from_url(http_url,'Shift_JIS')
    source.get_lines.foreach do |line|
      line.is_a?(String).should eq(true)
    end
  end
  it 'has #to_seq' do
    source = Source.from_url(http_url)
    source.to_seq.foreach do |c|
      c.is_a?(String).should eq(true)
    end
  end

end
