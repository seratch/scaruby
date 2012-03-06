# -*- encoding: utf-8 -*-

module Scaruby

  class Future

    attr_accessor :result, :mutex

    def initialize(mutex)
      @mutex = mutex
      @result = nil
    end

    def get
      @mutex.synchronize {
        @result
      }
    end

  end

  module ConcurrentOps

    def spawn(&block)
      Thread.new do
        yield 
      end
    end

    def future(&block)
      f = Future.new(Mutex.new)
      Thread.new do
        f.mutex.synchronize do
          f.result = yield
        end
      end
      f
    end

  end

end

include Scaruby::ConcurrentOps

