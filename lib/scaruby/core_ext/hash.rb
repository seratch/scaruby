# -*- encoding: utf-8 -*-

require 'scaruby/map'

class Hash
  def method_missing(name, *args, &block)
    result = Scaruby::Map.new(self).send(name, *args, &block)
    if result.is_a?(Scaruby::Map) then
      result.to_hash
    else
      result
    end
  end
end

