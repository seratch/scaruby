# Scala API in Ruby

Surely it works fine. 

But it mainly serves as a Ruby reference for Scala programmers.

## Gemfile

```
source "http://rubygems.org/"

gem 'scaruby'
```

## Trying on irb

```sh
bundle console
```

```ruby
irb(main):001:0> require 'scaruby'
=> false

irb(main):003:0> Option.new(nil).is_defined
=> false
irb(main):004:0> Option.new(123).is_defined
=> true

irb(main):004:0> Seq.new([1,2,3]).filter {|e| e < 2 }
=> #<Scaruby::Seq:0x9dca2e0 @array=[1]>
irb(main):004:0> Seq.new([1,2,3]).filter {|e| e < 2 }.to_a
=> [1]

irb(main):002:0> Seq.new([[1,2,3],[4,5],[6]]).flat_map {|e| e }.to_a
=> [1, 2, 3, 4, 5, 6]

irb(main):003:0> Seq.new([1,2,3]).fold_left(0) {|z,x| z + x }
=> 6

irb(main):001:0> require 'enumerable_to_scaruby'
=> true
irb(main):002:0> 1.upto(5).filter {|i| i < 3 }
=> #<Scaruby::Seq:0x8d43cdc @array=[1, 2]>
irb(main):003:0> 1.upto(5).filter {|i| i < 3 }.to_a
=> [1, 2]
```

## License

MIT License


