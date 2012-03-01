# -*- encoding: utf-8 -*-

require 'scaruby/seq'

module Enumerable
  def method_missing(name, *args, &block)
    Scaruby::Seq.new(self).send(name, *args, &block)
  end
end

