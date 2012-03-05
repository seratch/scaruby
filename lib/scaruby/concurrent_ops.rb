# -*- encoding: utf-8 -*-

module Scaruby
  module ConcurrentOps
    def spawn(&block)
      Thread.new do
        yield 
      end
    end
  end
end

include Scaruby::ConcurrentOps

