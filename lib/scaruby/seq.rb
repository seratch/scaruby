# -*- encoding: utf-8 -*-

module Scaruby
  class Seq
    include Enumerable

    attr :array

    def each(&block)
      @array.each do |e|
        yield e
      end
      nil
    end

    def self.apply(enumerable)
      Seq.new(enumerable)
    end

    def initialize(enumerable)
      assert_type(enumerable, Enumerable)
      @array = enumerable.to_a
    end

    def to_a
      @array
    end

    def corresponds(that, &predicate)
      @array.zip(that).inject(true) { |still_matched, e|
        if !still_matched
          false
        elsif yield e[0], e[1]
          true
        else
          false
        end
      }
    end

    def count(&predicate)
      @array.count(&predicate)
    end

    def diff(that)
      filter { |e| !that.include?(e) }
    end

    def distinct
      Seq.new(@array.uniq)
    end

    def drop(n)
      Seq.new(@array.drop(n))
    end

    def drop_right(n)
      Seq.new(@array.reverse.drop(n).reverse)
    end

    def drop_while(&predicate)
      Seq.new(@array.inject([false, []]) { |passed, x|
        no_need_to_yield, result = passed[0], passed[1]
        if no_need_to_yield
          [true, result.push(x)]
        elsif yield x
          passed
        else
          [true, result.push(x)]
        end
      }[1])
    end

    def ends_with(that)
      if that.nil? || that.length > @array.length
        return false
      end
      this_end = @array.reverse.take(that.length).reverse
      this_end.zip(that).inject(true) { |all_matched, a|
        if !all_matched
          false
        elsif a.length != 2
          false
        else
          a[0] == a[1]
        end
      }
    end

    def exists(&predicate)
      @array.any?(&predicate)
    end

    def filter(&predicate)
      Seq.new(@array.select { |e| yield e })
    end

    def filter_not(&predicate)
      Seq.new(@array.select { |e| !yield e })
    end

    def find(&predicate)
      Option.new(@array.find(&predicate))
    end

    def flat_map(&block)
      Seq.new(@array.inject([]) { |z, x|
        applied = yield x
        if applied.is_a?(Enumerable)
          applied.inject(z) { |z, elm| z.push(elm) }
        elsif applied.is_a?(Seq)
          applied.to_a.inject(z) { |z, elm| z.push(elm) }
        elsif applied.is_a?(Option)
          applied.is_defined ? z.push(applied.get) : z
        else
          z.push(applied)
        end
      })
    end

    def flatten
      Seq.new(@array.inject([]) { |z, x|
        if x.is_a?(Enumerable)
          x.inject(z) { |z, elm| z.push(elm) }
        elsif x.is_a?(Option)
          x.is_defined ? z.push(x.get) : z
        else
          z.push(x)
        end
      })
    end

    def fold_left(z, &block)
      @array.inject(z) { |z, x| yield z, x }
    end

    def fold_right(z, &block)
      @array.reverse.inject(z) { |z, x| yield z, x }
    end

    def forall(&predicate)
      @array.all?(&predicate)
    end

    def foreach(&block)
      @array.each do |e|
        yield e
      end
      nil
    end

    def group_by(&block)
      Map.new(@array.inject({}) { |z, e|
        if z[e].nil?
          z[e] = [e]
        else
          z[e] = z[e].push(e)
        end
        z
      })
    end

    def head
      @array.first
    end

    def head_option
      Option.new(@array.first)
    end

    def indices
      Seq.new(0.upto(@array.length-1))
    end

    def init
      Seq.new(@array.take(@array.length - 1))
    end

    def intersect(that)
      Seq.new(@array.inject([]) { |z, x|
        that.include?(x) ? z.push(x) : z
      })
    end

    def is_empty
      @array.nil? || @array.empty?
    end

    def last
      @array.last
    end

    def last_option
      Option.new(@array.last)
    end

    def length
      @array.length
    end

    def lift
      AppliableProc.new { |i| Option.new(@array[i]) }
    end

    def map(&block)
      #Seq.new(@array.collect {|e| yield e })
      Seq.new(@array.map { |e| yield e })
    end

    def max
      @array.max
    end

    def min
      @array.min
    end

    def mk_string(*args)
      case args.length
        when 0
          start_part, sep, end_part = '', '', ''
        when 1
          start_part, sep, end_part = '', args[0], ''
        when 2
          raise ArgumentError, 'Illegal number of arguments (' + args.length.to_s + ')'
        else
          start_part, sep, end_part = args[0], args[1], args[2]
      end
      start_part + @array.join(sep) + end_part
    end

    def non_empty
      !is_empty
    end

    def partition(&predicate)
      Seq.new(@array.chunk(&predicate).inject([[], []]) { |z, matched_and_elm|
        matched, elm = matched_and_elm[0], matched_and_elm[1].first
        if matched
          [z[0].push(elm), z[1]]
        else
          [z[0], z[1].push(elm)]
        end
      })
    end

    def patch(from, patch, replaced)
      #Seq.new(@array.take(from).concat(patch).concat(@array.drop(from).drop(replaced)))
      Seq.new(@array.take(from) + patch + @array.drop(from).drop(replaced))
    end

    def reverse
      Seq.new(@array.reverse)
    end

    def reverse_map(&block)
      #Seq.new(@array.reverse.collect {|e| yield e })
      Seq.new(@array.reverse.map { |e| yield e })
    end

    def same_elements(that)
      @array.zip(that).inject(true) { |still_same, a|
        if !still_same
          false
        elsif a.length != 2
          false
        else
          a[0] == a[1]
        end
      }
    end

    def scan_left(n, &block)
      Seq.new(@array.inject([n, [n]]) { |last_and_array, x|
        last, array = last_and_array[0], last_and_array[1]
        applied = yield last, x
        [applied, array.push(applied)]
      }[1])
    end

    def scan_right(n, &block)
      Seq.new(@array.reverse.inject([n, [n]]) { |last_and_array, x|
        last, array = last_and_array[0], last_and_array[1]
        applied = yield last, x
        [applied, array.push(applied)]
      }[1].reverse)
    end

    def size
      @array.length
    end

    def slice(from, until_n)
      Seq.new(@array.drop(from).take(until_n - from))
    end

    def sliding(len)
      result = []
      @array.each_with_index do |e, idx|
        if idx < (@array.length - len + 1)
          result.push(@array.slice(idx, len))
        end
      end
      Seq.new(result)
    end

    def sort_with(&predicate)
      @array.sort(&predicate)
    end

    def span(&predicate)
      result = @array.inject([true, [], []]) { |z, x|
        still_matched, first, second = z[0], z[1], z[2]
        if !still_matched
          [false, first, second.push(x)]
        elsif yield x
          [true, first.push(x), second]
        else
          [false, first, second.push(x)]
        end
      }
      Seq.new([result[1], result[2]])
    end

    def split_at(n)
      Seq.new([@array.take(n), @array.drop(n)])
    end

    def starts_with(that)
      if that.nil? || that.length > @array.length
        return false
      end
      this_start = @array.take(that.length)
      this_start.zip(that).inject(true) { |all_matched, a|
        if !all_matched
          false
        elsif a.length != 2
          false
        else
          a[0] == a[1]
        end
      }
    end

    def sum
      @array.inject(0) { |z, x| z + x }
    end

    def tail
      Seq.new(@array.drop(1))
    end

    def take(n)
      Seq.new(@array.take(n))
    end

    def take_right(n)
      Seq.new(@array.reverse.take(n).reverse)
    end

    def take_while(&predicate)
      Seq.new(@array.inject([false, []]) { |passed, x|
        is_already_unmatched, result = passed[0], passed[1]
        if is_already_unmatched
          passed
        elsif yield x
          [false, result.push(x)]
        else
          [true, result]
        end
      }[1])
    end

    def union(that)
      Seq.new(@array.concat(that))
    end

    def updated(idx, elm)
      Seq.new(@array.fill(elm, idx, 1))
    end

    def zip(that)
      Seq.new(@array.zip(that).select { |a, b| !a.nil? && !b.nil? })
    end

    def zip_with_index
      with_index = []
      @array.each_with_index do |v, idx|
        with_index.push([v, idx])
      end
      with_index
    end

  end
end 
