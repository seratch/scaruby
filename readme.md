# Scala API in Ruby

Surely it works fine. 

But it mainly serves as a Ruby reference for Scala programmers.

## Gemfile

```
source "http://rubygems.org/"

gem 'scaruby'
```

## Usage

See specs.

## Trying on irb

```sh
bundle console
```

```ruby
irb(main):008:0>  require 'scaruby'
=> false

irb(main):009:0> Option.new(nil).is_defined
=> false
irb(main):010:0> Option.apply(nil).is_defined
=> false
irb(main):011:0> Option.new(123).is_defined
=> true

irb(main):012:0> Seq.new([1,2,3]).filter {|e| e < 2 }
=> #<Scaruby::Seq:0x9772424 @array=[1]>
irb(main):013:0> Seq.new([1,2,3]).filter {|e| e < 2 }.to_a
=> [1]
irb(main):014:0> Seq.new([1,2,3]).fold_left(0) {|z,x| z + x }
=> 6

irb(main):025:0> Map.new({123=>'abc',23=>'bc',345=>'cde'}).filter {|k,v| k.to_s.size == 3 }
=> #<Scaruby::Map:0x94afa98 @hash={123=>"abc", 345=>"cde"}>
irb(main):026:0> Map.new({123=>'abc',23=>'bc',345=>'cde'}).filter {|k,v| k.to_s.size == 3 }.to_hash
=> {123=>"abc", 345=>"cde"}
```

`scaruby/converter` might be useful.

```ruby
irb(main):001:0> require 'scaruby/converter'
=> true
irb(main):002:0> 'abc'.to_option.is_defined
=> true
irb(main):003:0> 'abc'.to_option.get_or_else('zzz')
=> "abc"
irb(main):004:0> nil.to_option.is_defined
=> false
irb(main):005:0> [1,2,3].to_scaruby.foreach do |e| puts e end
1
2
3
=> [1, 2, 3]
```

It is also possible to extend Ruby with Scaruby. 

If the method is missing, the method in Scaruby will be invoked.

In this case, the methods already defined (i.e. flat_map, find and so on) are never replaced.

```ruby
irb(main):015:0> require 'scaruby/core_ext'
=> true
irb(main):016:0>  1.upto(5).filter {|i| i < 3 }
=> [1, 2]
irb(main):020:0>  1.upto(5).filter {|i| i < 3 }.foreach do |i|
irb(main):021:1*   puts i
irb(main):022:1> end
1
2
=> [1, 2]

irb(main):027:0> {123=>'abc',23=>'bc',345=>'cde'}.filter {|k,v| k.to_s.size == 3 }
=> {123=>"abc", 345=>"cde"}
```

## License

MIT License

https://github.com/seratch/scaruby/blob/master/LICENSE.txt


