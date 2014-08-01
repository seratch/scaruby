# -*- encoding: utf-8 -*-

require 'scaruby/core_ext'

describe Proc do

  up = Proc.new { |v| v.upcase }
  up_join = Proc.new { |a, b| "#{a.upcase} #{b.upcase}" }
  hello = Proc.new { "Hello!" }
  twice = Proc.new { |v| "#{v} #{v}" }

  it "should have #apply" do
    expect(hello.apply()).to eq("Hello!")
  end

  it "should have #compose" do
    expect(twice.compose(hello).apply()).to eq("Hello! Hello!")
    expect(twice.compose(up).apply("Hello!")).to eq("HELLO! HELLO!")
    expect(twice.compose(up_join).apply("Hello,", "World!")).to eq("HELLO, WORLD! HELLO, WORLD!")
  end

  it "should have #and_then" do
    expect(hello.and_then(twice).apply()).to eq("Hello! Hello!")
    expect(up.and_then(twice).apply("Hello!")).to eq("HELLO! HELLO!")
    expect(up_join.and_then(twice).apply("Hello,", "World!")).to eq("HELLO, WORLD! HELLO, WORLD!")
  end

end

