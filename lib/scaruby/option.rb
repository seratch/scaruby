# -*- encoding: utf-8 -*-

require 'scaruby/no_such_element_exception'

module Scaruby
  class Option

    def self.apply(value)
      Option.new(value)
    end

    def initialize(value)
      @value = value
    end

    def is_defined
      @value != nil
    end

    def get
      if is_defined then @value 
      else raise NoSuchElementException 
      end
    end

    def get_or_else(default_value)
      is_defined ? get : default_value
    end

    def map(&block) 
      is_defined ? Option.new(yield @value) : self
    end

  end
end

