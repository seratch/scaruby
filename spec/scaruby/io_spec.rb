# -*- encoding: utf-8 -*-

require 'scaruby'

describe Scaruby::IO::Source do

  http_url = 'http://seratch.github.com/'
  https_url = 'https://github.com/seratch/scaruby'

  it 'has from_file' do
    file = 'spec/scaruby_spec.rb'
    source = Source.from_file(file)
    source.to_seq.foreach do |c|
      expect(line.is_a?(String)).to be_truthy
    end
    lines = source.get_lines
    expect(lines.is_a?(Enumerable)).to be_truthy
    lines.foreach do |line|
      expect(line.is_a?(String)).to be_truthy
    end
  end
  it 'has from_bytes' do
    str = 'zzz 日本語を含む文字列 999'
    bytes = str.bytes.to_a
    source = Source.from_bytes(bytes)
    source.to_seq.foreach do |c|
      expect(c.is_a?(String)).to be_truthy
    end
    expect(source.get_lines.mk_string).to eq(str)
  end
  it 'has from_url with a http url' do
    source = Source.from_url(http_url)
    source.to_seq.foreach do |c|
      expect(c.is_a?(String)).to be_truthy
    end
  end
  it 'has from_url with a https url' do
    source = Source.from_url(https_url)
    source.to_seq.foreach do |c|
      expect(c.is_a?(String)).to be_truthy
    end
  end
  it 'has #get_lines' do
    source = Source.from_url(http_url, 'UTF-8')
    source.get_lines.foreach do |line|
      expect(line.is_a?(String)).to be_truthy
    end
  end
  it 'has #to_seq' do
    source = Source.from_url(http_url)
    source.to_seq.foreach do |c|
      expect(c.is_a?(String)).to be_truthy
    end
  end

end
