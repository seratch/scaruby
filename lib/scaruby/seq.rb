# -*- encoding: utf-8 -*-

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
  
    def count(&predicate)
      filter(&predicate).to_a.size
    end
  
    def diff(that)
      filter {|e| ! that.include?(e) }
    end
  
    def distinct 
      Seq.new(@enumerable.inject([]) {|z,x| 
        z.include?(x) ? z : z.push(x) 
      })
    end
  
    def drop(n)
      Seq.new(@enumerable.drop(n))
    end
  
    def drop_right(n)
      Seq.new(@enumerable.to_a.reverse.drop(n).reverse)
    end
  
    def drop_while(&predicate)
      Seq.new(@enumerable.inject([false,[]]) {|passed,x|
        no_need_to_yield = passed[0]
        result = passed[1]
        if no_need_to_yield then [true, result.push(x)]
        elsif yield x then passed
        else [true, result.push(x)] 
        end
      }[1])
    end

    def ends_with(that)
      if that.nil? || that.size > @enumerable.size then 
        return false
      end
      this_end = @enumerable.to_a.reverse.take(that.size).reverse
      this_end.zip(that).inject(true) {|all_matched,a| 
        if ! all_matched then false
        elsif a.size != 2 then false
        else a[0] == a[1] 
        end
      }
    end

    def exists(&predicate)
      @enumerable.inject(false) {|found,e| 
        if found then true
        else yield e 
        end
      }
    end

    def filter(&predicate)
      Seq.new(@enumerable.select {|e| yield e })
    end

    def filter_not(&predicate)
      Seq.new(@enumerable.select {|e| ! yield e })
    end

    def find(&predicate)
      Option.new(@enumerable.find(&predicate))
    end

    def flat_map(&block)
      Seq.new(@enumerable.inject([]) {|z,x| 
        applied = yield x
        if applied.is_a?(Enumerable) then
          applied.inject(z) {|z,elm| z.push(elm) }
        elsif applied.is_a?(Option) then 
          applied.is_defined ? z.push(applied.get) : z
        else z.push(applied) 
        end
      })
    end
 
    def flatten
      Seq.new(@enumerable.inject([]) {|z,x|
        if x.is_a?(Enumerable) then
          x.inject(z) {|z,elm| z.push(elm) }
        elsif x.is_a?(Option) then 
          x.is_defined ? z.push(x.get) : z
        else 
          z.push(x) 
        end
      })
    end
 
    def fold_left(z, &block)
      @enumerable.inject(z) {|z,x| yield z, x }
    end

    def forall(&predicate)
      @enumerable.inject(true) {|all_matched,e|
        if ! all_matched then false
        else yield e 
        end
      }
    end

    def foreach(&block)
      @enumerable.each do |e| yield e end
    end
  
    def head
      @enumerable.first
    end
  
    def head_option
      Option.new(@enumerable.first)
    end

    def indices
      Seq.new(0.upto @enumerable.size-1)
    end

    def init
      Seq.new(@enumerable.take(@enumerable.size - 1))
    end

    def intersect(that)
      Seq.new(@enumerable.inject([]) {|z,x|
        that.include?(x) ? z.push(x) : z
      })
    end

    def is_empty
      @enumerable.nil? || @enumerable.to_a.empty?
    end

    def last
      @enumerable.last
    end

    def last_option
      Option.new(@enumerable.last)
    end

    def lift
      AppliableProc.new {|i| Option.new(@enumerable[i]) }
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

    def mk_string(*args)
      case args.size
      when 0
        start_part, sep, end_part = '', '', ''
      when 1
        start_part, end_part = '', ''
        sep = args[0]
      when 2
        raise 'Illegal number of arguments'
      else
        start_part = args[0]
        sep = args[1]
        end_part = args[2]
      end
      start_part + @enumerable.to_a.join(sep) + end_part
    end

    def non_empty
      ! is_empty
    end

    def partition(&predicate)
      Seq.new(@enumerable.inject([[],[]]) {|z,x|
        if yield x then [z[0].push(x),z[1]]
        else [z[0],z[1].push(x)] 
        end
      })
    end

    def patch(from, patch, replaced) 
      result = []
      @enumerable.take(from).each do |e| result.push(e) end
      patch.each do |e| result.push(e) end
      @enumerable.drop(from + replaced).each do |e| result.push(e) end
      Seq.new(result)
    end

    def reverse
      Seq.new(@enumerable.to_a.reverse)
    end

    def reverse_map(&block)
      Seq.new(@enumerable.to_a.reverse.map {|e|
        yield e   
      })
    end

    def same_elements(that)
      @enumerable.zip(that).inject(true) {|still_same,a|
        if ! still_same then false
        elsif a.size != 2 then false
        else a[0] == a[1] 
        end
      }
    end

    def scan_left(n, &block)
      Seq.new(@enumerable.inject([n,[n]]) {|last_and_array,x|
        last = last_and_array[0]
        array = last_and_array[1]
        applied = yield last, x
        [applied, array.push(applied)]
      }[1])
    end

    def scan_right(n, &block)
      Seq.new(@enumerable.to_a.reverse.inject([n,[n]]) {|last_and_arr,x|
        last = last_and_arr[0]
        arr = last_and_arr[1]
        applied = yield last, x
        [applied, arr.push(applied)]
      }[1].reverse)
    end

    def slice(from, until_n)
      Seq.new(@enumerable.drop(from).take(until_n - from))
    end

    def sliding(len)
      result = []
      @enumerable.each_with_index do |e,idx|
        if idx < @enumerable.size - len + 1 then 
          result.push(@enumerable.slice(idx, len))
        end
      end
      Seq.new(result)
    end

    def sort_with(&predicate)
      @enumerable.sort(&predicate)
    end

    def span(&predicate)
      result = @enumerable.inject([true,[],[]]) {|z,x|
        still_matched = z[0]
        first = z[1]
        second = z[2]
        if ! still_matched then [false,first,second.push(x)]
        elsif yield x then [true,first.push(x),second]
        else [false,first,second.push(x)] 
        end
      }
      Seq.new([result[1],result[2]])
    end

    def split_at(n)
      Seq.new([@enumerable.take(n),@enumerable.drop(n)])
    end

    def starts_with(that)
      if that.nil? || that.size > @enumerable.size then 
        return false
      end
      this_start = @enumerable.to_a.take(that.size)
      this_start.zip(that).inject(true) {|all_matched,a|
        if ! all_matched then false
        elsif a.size != 2 then false
        else a[0] == a[1]
        end
      }
    end

    def sum
      @enumerable.inject(0) {|z,x| z + x }
    end

    def tail
      Seq.new(@enumerable.drop(1))
    end

    def take(n)
      Seq.new(@enumerable.take(n))
    end

    def take_right(n)
      Seq.new(@enumerable.to_a.reverse.take(n).reverse)
    end

    def take_while(&predicate)
      Seq.new(@enumerable.inject([false,[]]) {|passed,x|
        is_already_unmatched = passed[0]
        result = passed[1]
        if is_already_unmatched then passed
        elsif yield x then [false,result.push(x)]
        else [true, result] 
        end
      }[1])
    end

    def union(that)
      Seq.new(@enumerable.concat(that))
    end

    def zip(that)
      Seq.new(@enumerable.zip(that).select {|a,b| ! a.nil? && ! b.nil? })
    end

    def zip_with_index
      with_index = []
      @enumerable.each_with_index do |v,idx|
        with_index.push([v,idx])
      end
      with_index
    end
  
  end  
end 
