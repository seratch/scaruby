# -*- encoding: utf-8 -*-

require 'scaruby/appliable_proc'
require 'scaruby/concurrent'
require 'scaruby/converter'
require 'scaruby/io'
require 'scaruby/map'
require 'scaruby/exception'
require 'scaruby/option'
require 'scaruby/seq'
require 'scaruby/version'

module Scaruby

  module Predef

    def assert(assertion)
      unless assertion then
        raise AssertionError, 'Assertion failed'
      end
    end

    def println(any)
      puts any.to_s
    end

    def read_line
      input = readline
      input.sub(/\r?\n/, '')
    end

  end
end

include Scaruby
include Scaruby::Predef


