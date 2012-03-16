# -*- encoding: utf-8 -*-

require 'scaruby/seq'

module Enumerable
  def method_missing(name, *args, &block)
    result = Scaruby::Seq.new(self).send(name, *args, &block)
    if result.is_a?(Scaruby::Seq)
      result.to_a
    else
      result
    end
  end
end

