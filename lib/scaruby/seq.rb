#encoding: UTF-8
  
require 'scaruby/option'

module Scaruby
  class Seq
  
    def self.apply(enumerable)
      Seq.new(enumerable)
    end
  
    def initialize(enumerable)
      @enumerable = enumerable
    end

    def to_a
      @enumerable.to_a
    end
  
    def count(&block)
      filter(&block).to_a.size
    end
  
    def diff(that)
      filter {|e| ! that.include?(e) }
    end
  
    def distinct 
      Seq.new(@enumerable.inject([]) {|z,x| z.include?(x) ? z : z.push(x) })
    end
  
    def drop(n)
      Seq.new(@enumerable.drop(n))
    end
  
    def drop_right(n)
      Seq.new(@enumerable.to_a.reverse.drop(n).reverse)
    end
  
    def drop_while(&block)
      Seq.new(@enumerable.inject([false,[]]) {|passed,x|
        is_already_unmatched = passed[0]
        result = passed[1]
        if is_already_unmatched then passed
        elsif yield x then [false,result.push(x)]
        else [true, result] end
      }[1])
    end
  
    def filter(&block)
      Seq.new(@enumerable.select {|e| yield e })
    end
  
    def flat_map(&block)
      Seq.new(@enumerable.inject([]) {|z,x| 
        applied = yield x
        if applied.is_a?(Enumerable) then
          applied.each {|elm| z.push(elm) }
          z
        elsif applied.is_a?(Option) then 
          applied.is_defined ? z.push(applied.get) : z
        else z.push(applied) end
      })
    end
  
    def fold_left(z, &block)
      @enumerable.inject(z) {|z,x| yield z, x }
    end
  
    def head
      @enumerable.first
    end
  
    def head_option
      Option.apply(@enumerable.first)
    end
  
    def map(&block)
      Seq.new(@enumerable.map {|e| yield e })
    end
  
    def max 
      @enumerable.max
    end
  
    def min 
      @enumerable.min
    end
  
  end  
end 
