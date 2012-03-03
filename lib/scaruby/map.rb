# -*- encoding: utf-8 -*-

module Scaruby
  class Map

    def self.empty
      {}
    end

    def initialize(hash)
      @hash = hash
    end

    def to_hash
      @hash
    end

    def to_a
      @hash.to_a
    end

    def contains(key)
      @hash.include?(key)
    end

    def count(&predicate)
      count = 0
      @hash.each do |k,v|
        if yield k, v then 
          count += 1
        end
      end
      count
    end

    def exists(&predicate)
      @hash.to_a.inject(false) {|found,kv|
        if found then 
          true
        else 
          k, v = kv[0], kv[1]
          yield k, v
        end
      }
    end

    def filter(&predicate)
      Map.new(@hash.reject {|k,v| ! yield k, v })
    end

    def filter_keys(&predicate)
      Map.new(@hash.reject {|k,v| ! yield k })
    end

    def filter_not(&predicate)
      Map.new(@hash.reject {|k,v| yield k, v })
    end

    def find(&predicate)
      Option.new(@hash.inject([false,[]]) {|z,kv|
        found, matched_kv = z[0], z[1]
        if found then 
          z
        elsif yield kv[0], kv[1] then 
          [true,kv]
        else 
          [false,[]]
        end
      }[1])
    end

    def forall(&predicate)
      @hash.inject(true) {|still_matched,kv|
        if !still_matched then 
          false
        else 
          k, v = kv[0], kv[1]
          yield k, v
        end
      }
    end

    def foreach(&block)
      @hash.each do |k,v| yield k, v end
    end

    def get_or_else(key, default_value)
      value = @hash[key]
      value.nil? ? default_value : value
    end

    def is_empty
      @hash.nil? || @hash.empty?
    end

    def key_set
      @hash.keys
    end

    def lift
      AppliableProc.new {|k| Option.new(@hash[k]) }
    end

    def map(&block)
      Map.new(Hash[*@hash.to_a.map {|k,v| yield k, v }.flatten])
    end

    def mk_string(*args)
      case args.size
      when 0
        start_part, sep, end_part = '{', ', ', '}'
      when 1
        start_part, sep, end_part = '', args[0], ''
      when 2
        raise 'Illegal number of arguments (2)'
      else
        start_part, sep, end_part = args[0], args[1], args[2]
      end
      #start_part + @hash.to_a.collect {|k,v| k.to_s + '=>' + v.to_s }.join(sep) + end_part
      start_part + @hash.to_a.map {|k,v| k.to_s + '=>' + v.to_s }.join(sep) + end_part
    end

    def non_empty
      ! is_empty
    end

  end
end

