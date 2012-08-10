# -*- encoding: utf-8 -*-

require 'scaruby/appliable_proc'

describe Scaruby::AppliableProc do

  up = Scaruby::AppliableProc.new { |v| v.upcase }
  up_join = Scaruby::AppliableProc.new { |a, b| "#{a.upcase} #{b.upcase}" }
  hello = Scaruby::AppliableProc.new { "Hello!" }
  twice = Scaruby::AppliableProc.new { |v| "#{v} #{v}" }

  it "should have #apply" do
    hello.apply().should ==("Hello!")
  end

  it "should have #compose" do
    twice.compose(hello).apply().should ==("Hello! Hello!")
    twice.compose(up).apply("Hello!").should ==("HELLO! HELLO!")
    twice.compose(up_join).apply("Hello,", "World!").should ==("HELLO, WORLD! HELLO, WORLD!")
  end

  it "should have #and_then" do
    hello.and_then(twice).apply().should ==("Hello! Hello!")
    up.and_then(twice).apply("Hello!").should ==("HELLO! HELLO!")
    up_join.and_then(twice).apply("Hello,", "World!").should ==("HELLO, WORLD! HELLO, WORLD!")
  end

end