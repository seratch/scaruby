#encoding: UTF-8

require 'scaruby/seq'

class Array
  def method_missing(name, *args, &block)
    Scaruby::Seq.new(self).send(name, *args, &block)
  end
end

