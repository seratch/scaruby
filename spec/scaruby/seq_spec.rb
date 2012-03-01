# -*- encoding: utf-8 -*-

require 'scaruby'

describe Seq do

  one_to_five = 1.upto 5
  one_to_five_shuffled = one_to_five.sort_by {rand}

  it 'has #to_a' do
    Seq.new(one_to_five).to_a.should eq([1,2,3,4,5])
  end
  it 'has #count' do
    Seq.new(one_to_five).count {|i| i > 2 }.should eq(3)
  end
  it 'has #diff' do
    Seq.new([1,2,3]).diff([2,3,4]).to_a.should eq([1])
  end
  it 'has #distinct' do
    Seq.new([1,2,4,1,3,3,3,2,4,1]).distinct.to_a.should eq([1,2,4,3])
  end
  it 'has #drop' do
    Seq.new(one_to_five).drop(3).to_a.should eq([4,5])
    Seq.new(one_to_five).drop(7).to_a.should eq([])
  end
  it 'has #drop_right' do
    Seq.new(one_to_five).drop_right(3).to_a.should eq([1,2])
    Seq.new(one_to_five).drop_right(7).to_a.should eq([])
  end
  it 'has #drop_while' do
    Seq.new([5,3,2,4,1]).drop_while {|e| e > 2 }.to_a.should eq([2,4,1])
  end
  it 'has #ends_with' do
    Seq.new([1,2,3]).ends_with([1,2]).should eq(false)
    Seq.new([1,2,3]).ends_with([1,2,3]).should eq(true)
    Seq.new([1,2,3]).ends_with([1,1,2,3]).should eq(false)
    Seq.new([1,2,3]).ends_with([2,3]).should eq(true)
    Seq.new([1,2,3]).ends_with([3]).should eq(true)
  end
  it 'has #exists' do
    Seq.new([1,2,3]).exists {|i| i < 2 }.should eq(true)
    Seq.new([1,2,3]).exists {|i| i < 4 }.should eq(true)
    Seq.new([2,3,4]).exists {|i| i > 4 }.should eq(false)
  end
  it 'has #filter' do
    Seq.new(one_to_five).filter {|i| i > 3 }.to_a.should eq([4,5])
    Seq.new(one_to_five).filter {|i| i > 10 }.to_a.should eq([])
  end
  it 'has #filter_not' do
    Seq.new(one_to_five).filter_not {|i| i > 3 }.to_a.should eq([1,2,3])
    Seq.new(one_to_five).filter_not {|i| i > 10 }.to_a.should eq([1,2,3,4,5])
  end
  it 'has #find' do
    some = Seq.new(one_to_five).find {|i| i < 3 }
    some.get.should eq(1)
    some = Seq.new(one_to_five).find {|i| i > 10 }
    some.is_defined.should eq(false)
  end
  it 'has #flat_map and it works with nested arrays' do
    Seq.new([[1,2],[3,4],[5]]).flat_map {|i| i }.to_a.should eq([1,2,3,4,5])
  end
  it 'has #flat_map and it works with Option elements' do
    Seq.new([1,2,nil,3]).flat_map {|i| Option.new(i) }.to_a.should eq([1,2,3])
  end
  it 'has #fold_left' do
    Seq.new(one_to_five_shuffled).fold_left(0) {|z,x| z + x }.should eq(15)
  end
  it 'has #flatten' do
    Seq.new([[1,2],[3,4],[5]]).flatten.to_a.should eq([1,2,3,4,5])
    Seq.new(
      [Option.new(1),
       Option.new(2),
       Option.new(nil),
       Option.new(3)]
    ).flatten.to_a.should eq([1,2,3])
  end
  it 'has #forall' do
    Seq.new([1,2,3]).forall {|i| i > 0 }.should eq(true)
    Seq.new([1,2,3]).forall {|i| i > 1 }.should eq(false)
  end
  it 'has #foreach' do
    count = 0
    Seq.new([1,2,3]).foreach do |i| 
      count += 1
    end
    count.should eq(3)
  end
  it 'has #head' do
    Seq.new(one_to_five).head.should eq(1)
  end
  it 'has #head_option and it works with Some' do
    some = Seq.new(one_to_five).head_option
    some.get_or_else(999).should eq(1)
  end
  it 'has #head_option and it works with None' do
    none = Seq.new([]).head_option
    none.get_or_else(999).should eq(999)
  end
  it 'has #indices' do
    Seq.new([1,2,3]).indices.to_a.should eq([0,1,2])
  end
  it 'has #init' do
    Seq.new([1,2,3]).init.to_a.should eq([1,2])
  end
  it 'has #intersect' do
    Seq.new([1,2,3]).intersect([2,3,4]).to_a.should eq([2,3])
  end
  it 'has #is_empty' do
    Seq.new([1,2,3]).is_empty.should eq(false)
    Seq.new([nil]).is_empty.should eq(false)
    Seq.new([]).is_empty.should eq(true)
    Seq.new(nil).is_empty.should eq(true)
  end
  it 'has #last' do
    Seq.new([1,2,3]).last.should eq(3)
  end
  it 'has #last_option' do
    some = Seq.new([1,2,3]).last_option
    some.get.should eq(3)
    none = Seq.new([]).last_option
    none.is_defined.should eq(false)
  end
  it 'has #lift' do
    seq_lift = Seq.new([1,2,3]).lift
    seq_lift.apply(0).get.should eq(1)
    seq_lift.apply(1).get.should eq(2)
    seq_lift.apply(2).get.should eq(3)
    seq_lift.apply(3).is_defined.should eq(false)
    seq_lift.call(0).get.should eq(1)
    seq_lift.call(1).get.should eq(2)
    seq_lift.call(2).get.should eq(3)
    seq_lift.call(3).is_defined.should eq(false)
  end
  it 'has #map' do
    Seq.new([1,2,3]).map {|i| i + i }.to_a.should eq([2,4,6])
  end
  it 'has #max' do
    Seq.new(one_to_five_shuffled).max.should eq(5)
  end
  it 'has #min' do
    Seq.new(one_to_five_shuffled).min.should eq(1)
  end
  it 'has #mk_string' do
    Seq.new(one_to_five).mk_string.should eq('12345')
    Seq.new(one_to_five).mk_string(',').should eq('1,2,3,4,5')
    Seq.new(one_to_five).mk_string('^',',','$').should eq('^1,2,3,4,5$')
    begin
      Seq.new(one_to_five).mk_string('a','b').should eq(nil)
    rescue RuntimeError
    end
    Seq.new(one_to_five).mk_string('^',',','$','zzz').should eq('^1,2,3,4,5$')
  end
  it 'has #non_empty' do
    Seq.new(one_to_five).non_empty.should eq(true)
    Seq.new([]).non_empty.should eq(false)
    Seq.new(nil).non_empty.should eq(false)
  end
  it 'has #partition' do
    Seq.new([5,2,3,1,4,2,3]).partition {|i| i < 3 }.to_a.should eq([[2,1,2],[5,3,4,3]])
  end
  it 'has #patch' do
    Seq.new([5,2,3,1,4,2,3]).patch(3,[111,222],3).to_a.should eq([5,2,3,111,222,3])
  end
  it 'has #reduce_left' do
  end
  it 'has #reduce_right' do
  end
  it 'has #reverse' do
    Seq.new([1,2,3]).reverse.to_a.should eq([3,2,1])
  end
  it 'has #reverse_iterator' do
  end
  it 'has #reverse_map' do
    Seq.new([1,2,3]).reverse_map {|i| i + i }.to_a.should eq([6,4,2])
  end
  it 'has #same_elements' do
    Seq.new([1,2,3]).same_elements([1,2,3]).should eq(true)
    Seq.new([1,2,3]).same_elements([1,3,2]).should eq(false)
    Seq.new([1,2,3]).same_elements([1,2]).should eq(false)
  end
  it 'has #scan_left' do
    Seq.new([1,2,3]).scan_left(1) {|a,b| a + b }.to_a.should eq([1,2,4,7])
  end
  it 'has #scan_right' do
    Seq.new([1,2,3]).scan_right(1) {|a,b| a + b }.to_a.should eq([7,6,4,1])
  end
  it 'has #slice' do
    Seq.new([1,2,3,4,5]).slice(1,1).to_a.should eq([])
    Seq.new([1,2,3,4,5]).slice(1,2).to_a.should eq([2])
    Seq.new([1,2,3,4,5]).slice(1,3).to_a.should eq([2,3])
    Seq.new([1,2,3,4,5]).slice(1,4).to_a.should eq([2,3,4])
  end
  it 'has #sliding' do
    Seq.new([1,2,3,4,5]).sliding(2).to_a.should eq([[1,2],[2,3],[3,4],[4,5]])
  end
  it 'has #sort_with' do
    Seq.new([1,3,2,4,5]).sort_with {|a,b| b <=> a }.to_a.should eq([5,4,3,2,1])
  end
  it 'has #span' do
    Seq.new([1,2,3,2,1]).span {|i| i < 3 }.to_a.should eq([[1,2],[3,2,1]])
  end
  it 'has #split_at' do
    Seq.new([1,2,3,2,1]).split_at(3).to_a.should eq([[1,2,3],[2,1]])
  end
  it 'has #starts_with' do
    Seq.new([1,2,3]).starts_with([1]).should eq(true)
    Seq.new([1,2,3]).starts_with([1,2]).should eq(true)
    Seq.new([1,2,3]).starts_with([1,2,3]).should eq(true)
    Seq.new([1,2,3]).starts_with([1,2,3,4]).should eq(false)
    Seq.new([1,2,3]).starts_with([2,3]).should eq(false)
    Seq.new([1,2,3]).starts_with([4,1,2,3]).should eq(false)
  end
  it 'has #sum' do
    Seq.new([1,2,3]).sum.should eq(6)
  end
  it 'has #tail' do
    Seq.new([1,2,3]).tail.to_a.should eq([2,3])
    Seq.new([]).tail.to_a.should eq([])
  end
  it 'has #take' do
    Seq.new([1,2,3]).take(0).to_a.should eq([])
    Seq.new([1,2,3]).take(1).to_a.should eq([1])
    Seq.new([1,2,3]).take(2).to_a.should eq([1,2])
    Seq.new([1,2,3]).take(3).to_a.should eq([1,2,3])
    Seq.new([1,2,3]).take(4).to_a.should eq([1,2,3])
  end
  it 'has #take_right' do
    Seq.new([1,2,3]).take_right(0).to_a.should eq([])
    Seq.new([1,2,3]).take_right(1).to_a.should eq([3])
    Seq.new([1,2,3]).take_right(2).to_a.should eq([2,3])
    Seq.new([1,2,3]).take_right(3).to_a.should eq([1,2,3])
    Seq.new([1,2,3]).take_right(4).to_a.should eq([1,2,3])
  end
  it 'has #take_while' do
    Seq.new([5,3,2,4,1]).take_while {|e| e > 2 }.to_a.should eq([5,3])
  end
  it 'has #union' do
    Seq.new([1,2,3]).union([2,3,4]).to_a.should eq([1,2,3,2,3,4])
  end
  it 'has #zip' do
    Seq.new([1,2,3]).zip([2,3]).to_a.should eq([[1,2],[2,3]])
    Seq.new([1,2,3]).zip([2,3,4]).to_a.should eq([[1,2],[2,3],[3,4]])
    Seq.new([1,2,3]).zip([2,3,4,5]).to_a.should eq([[1,2],[2,3],[3,4]])
  end
  it 'has #zip_with_index' do
    Seq.new([]).zip_with_index.to_a.should eq([])
    Seq.new([1,2,3]).zip_with_index.to_a.should eq([[1,0],[2,1],[3,2]])
  end
end




