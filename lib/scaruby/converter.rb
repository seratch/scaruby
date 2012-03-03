# -*- encoding: utf-8 -*-

require 'scaruby/seq'
require 'scaruby/map'

module Enumerable
  def to_scaruby
    Scaruby::Seq.new(self)
  end
end

class Hash
  def to_scaruby
    Scaruby::Map.new(self)
  end
end

class Object
  def to_option
    Scaruby::Option.new(self)
  end
end
