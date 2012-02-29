#encoding: UTF-8

require 'scaruby/no_such_element_exception'

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
    if @value != nil then @value
    else raise NoSuchElementException end
  end

  def get_or_else(default_value)
    if @value != nil then @value
    else default_value end
  end

  def map(&block) 
    if is_defined then Option.apply(yield @value)
    else self end
  end

end

