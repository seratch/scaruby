# -*- encoding: utf-8 -*-

module Scaruby
  class Map < Hash

    def each(&block)
      @hash.each do |k,v|
        yield k, v
      end
      nil
    end

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
      @hash.count(&predicate)
    end

    def exists(&predicate)
      @hash.any?(&predicate)
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
      Option.new(@hash.find(&predicate))
    end

    def forall(&predicate)
      @hash.all?(&predicate)
    end

    def foreach(&block)
      @hash.each do |k,v| 
        yield k, v 
      end
      nil
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
      #Map.new(Hash[*@hash.to_a.collect {|k,v| yield k, v }.flatten])
      Map.new(Hash[*@hash.to_a.map {|k,v| yield k, v }.flatten])
    end

    def minus(*keys)
      copied = @hash.dup
      keys.each do |key|
        copied.delete(key)
      end
      Map.new(copied)
    end

    def plus(elems)
      copied = @hash.dup
      elems.each do |elm|
        k,v = elm[0], elm[1]
        copied[k] = v
      end
      Map.new(copied)
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

    def updated(k, v)
      copied = @hash.dup
      copied[k] = v
      Map.new(copied)
    end

    def unzip
      Seq.new([@hash.keys,@hash.values])
    end

  end
end

