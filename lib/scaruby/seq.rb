#encoding: UTF-8

require 'scaruby/option'

class Seq

  def self.apply(enumerable)
    Seq.new(enumerable)
  end

  def initialize(enumerable)
    @enumerable = enumerable
  end

  def count(&block)
    filter(&block).size
  end

  def diff(that)
    filter {|e| ! that.include?(e) }
  end

  def distinct 
    @enumerable.inject([]) {|z,x|
      if z.include?(x) then z else z.push(x) end
    }  
  end

  def drop(n)
    @enumerable.drop(n)
  end

  def drop_right(n)
    @enumerable.to_a.reverse.drop(n).reverse
  end

  def drop_while(&block)
    @enumerable.inject([false,[]]) {|passed,x|
      is_already_unmatched = passed[0]
      result = passed[1]
      if is_already_unmatched then passed
      elsif yield x then [false,result.push(x)]
      else [true, result] end
    }[1]
  end

  def filter(&block)
    @enumerable.select {|e| yield e }
  end

  def flat_map(&block)
    @enumerable.inject([]) {|z,x| 
      applied = yield x
      if applied.is_a?(Enumerable) then
        applied.each {|elm| z.push(elm) }
        z
      elsif applied.is_a?(Option) then 
        if applied.is_defined then z.push(applied.get) 
        else z end
      else z.push(applied) end
    }
  end

  def fold_left(z, &block)
    @enumerable.inject(z) {|z, x| yield z, x }
  end

  def head
    @enumerable.first
  end

  def head_option
    Option.apply(@enumerable.first)
  end

  def map(&block)
    @enumerable.map {|e| yield e }
  end

  def max 
    @enumerable.max
  end

  def min 
    @enumerable.min
  end

end  

