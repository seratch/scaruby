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

  module Commons

    def assert_type(v, *types)
      unless v.nil? then
        found = types.inject(false) {|found,type|
          if found then true
          else v.is_a?(type)
          end
        }
        unless found then
          raise AssertionError, 
            "The type of `#{v}` should be whichever of [#{types.join(', ')}] but actually #{v.class}."
        end
      end
    end

  end

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
include Scaruby::Commons
include Scaruby::Predef


