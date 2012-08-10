# -*- encoding: utf-8 -*-

require 'scaruby/function'

class Proc

  alias_method :apply, :call

  def method_missing(name, *args, &block)
    if self.is_a? Scaruby::Function
      self.send(name, *args, &block)
    else
      self.extend(Scaruby::Function).send(name, *args, &block)
    end
  end

end

