# -*- encoding: utf-8 -*-

module Scaruby
  class Option

    attr :value

    def self.apply(value)
      Option.new(value)
    end

    def initialize(value)
      @value = value
    end

    def is_empty
      @value == nil
    end

    def is_defined
      @value != nil
    end

    def get
      if is_defined
        @value
      else
        raise NoSuchElementException
      end
    end

    def get_or_else(default_value)
      is_defined ? get : default_value
    end

    def map(&block)
      is_defined ? Option.new(yield @value) : self
    end

    def fold(if_empty, &block)
      is_empty ? if_empty : yield(@value)
    end

  end
end

