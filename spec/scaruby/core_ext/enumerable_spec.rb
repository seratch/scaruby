# -*- encoding: utf-8 -*-

require 'scaruby/core_ext'

describe Enumerable do

  one_to_five = 1.upto 5
  one_to_five_shuffled = one_to_five.sort_by { rand }

  it 'has #to_a' do
    expect(one_to_five.to_a).to eq([1, 2, 3, 4, 5])
  end
  it 'has #corresponds' do
    expect([1, 2, 3].corresponds([1, 2, 3]) { |a, b| a == b }).to be_truthy
    expect([1, 2, 3].corresponds([3, 1, 2]) { |a, b| a == b }).to be_falsey
  end
  it 'has #count' do
    expect(one_to_five.count { |i| i > 2 }).to eq(3)
  end
  it 'has #diff' do
    expect([1, 2, 3].diff([2, 3, 4]).to_a).to eq([1])
  end
  it 'has #distinct' do
    expect([1, 2, 4, 1, 3, 3, 3, 2, 4, 1].distinct.to_a).to eq([1, 2, 4, 3])
  end
  it 'has #drop' do
    expect(one_to_five.drop(3).to_a).to eq([4, 5])
    expect(one_to_five.drop(7).to_a).to eq([])
  end
  it 'has #drop_right' do
    expect(one_to_five.drop_right(3).to_a).to eq([1, 2])
    expect(one_to_five.drop_right(7).to_a).to eq([])
  end
  it 'has #drop_while' do
    expect([5, 3, 2, 4, 1].drop_while { |e| e > 2 }.to_a).to eq([2, 4, 1])
  end
  it 'has #ends_with' do
    expect([1, 2, 3].ends_with([1, 2])).to be_falsey
    expect([1, 2, 3].ends_with([1, 2, 3])).to be_truthy
    expect([1, 2, 3].ends_with([1, 1, 2, 3])).to be_falsey
    expect([1, 2, 3].ends_with([2, 3])).to be_truthy
    expect([1, 2, 3].ends_with([3])).to be_truthy
  end
  it 'has #exists' do
    expect([1, 2, 3].exists { |i| i < 2 }).to be_truthy
    expect([1, 2, 3].exists { |i| i < 4 }).to be_truthy
    expect([2, 3, 4].exists { |i| i > 4 }).to be_falsey
  end
  it 'has #filter' do
    expect(one_to_five.filter { |i| i > 3 }.to_a).to eq([4, 5])
    expect(one_to_five.filter { |i| i > 10 }.to_a).to eq([])
  end
  it 'has #filter_not' do
    expect(one_to_five.filter_not { |i| i > 3 }.to_a).to eq([1, 2, 3])
    expect(one_to_five.filter_not { |i| i > 10 }.to_a).to eq([1, 2, 3, 4, 5])
  end
  it 'has #find' do
    some = one_to_five.find { |i| i < 3 }
    # the already defined method is called
    #some.get.should eq(1)
    expect(some).to eq(1)
    none = one_to_five.find { |i| i > 10 }
    # the already defined method is called
    #none.is_defined.should be_falsey
    expect(none).to eq(nil)
  end
  it 'has #flat_map and it works with nested arrays' do
    expect([[1, 2], [3, 4], [5]].flat_map { |i| i }.to_a).to eq([1, 2, 3, 4, 5])
  end
  it 'has #flat_map and it works with Option elements' do
    # the already defined method is called
    #([1,2,nil,3]).flat_map {|i| Option.new(i) }.to_a.should eq([1,2,3])
    [1, 2, nil, 3].flat_map { |i| Option.new(i) }.to_a do |opt|
      expect(opt.is_a?(Option)).to be_truthy
    end
  end
  it 'has #fold_left' do
    input = [1, 2, 3]
    expected = [1, 2, 3]
    idx = 0
    expect(input.fold_left(0) { |z, x|
      expect(x).to eq(expected[idx])
      idx += 1
      z + x
    }).to eq(6)
  end
  it 'has #fold_right' do
    input = [1, 2, 3]
    expected = [3, 2, 1]
    idx = 0
    expect(input.fold_right(0) { |z, x|
      expect(x).to eq(expected[idx])
      idx += 1
      z + x
    }).to eq(6)
  end
  it 'has #flatten' do
    expect([[1, 2], [3, 4], [5]].flatten.to_a).to eq([1, 2, 3, 4, 5])
    [Option.new(1),
     Option.new(2),
     Option.new(nil),
     Option.new(3)].flatten.to_a.each do |opt|
      expect(opt.is_a?(Option)).to be_truthy
    end
  end
  it 'has #forall' do
    expect([1, 2, 3].forall { |i| i > 0 }).to be_truthy
    expect([1, 2, 3].forall { |i| i > 1 }).to be_falsey
  end
  it 'has #foreach' do
    count = 0
    returned = ([1, 2, 3]).foreach do |i|
      count += 1
    end
    expect(count).to eq(3)
    expect(returned).to eq(nil)
  end
  it 'has #group_by' do
    expected = {3 => [3, 3, 3], 1 => [1, 1, 1], 2 => [2, 2]}
    expect([1, 1, 1, 2, 3, 2, 3, 3].group_by { |i| i }.to_hash).to eq(expected)
  end
  it 'has #head' do
    expect(one_to_five.head).to eq(1)
  end
  it 'has #head_option and it works with Some' do
    some = one_to_five.head_option
    expect(some.get_or_else(999)).to eq(1)
  end
  it 'has #head_option and it works with None' do
    none = ([]).head_option
    expect(none.get_or_else(999)).to eq(999)
  end
  it 'has #indices' do
    expect([1, 2, 3].indices.to_a).to eq([0, 1, 2])
  end
  it 'has #init' do
    expect([1, 2, 3].init.to_a).to eq([1, 2])
  end
  it 'has #intersect' do
    expect([1, 2, 3].intersect([2, 3, 4]).to_a).to eq([2, 3])
  end
  it 'has #is_empty' do
    expect([1, 2, 3].is_empty).to be_falsey
    expect([nil].is_empty).to be_falsey
    expect([].is_empty).to be_truthy
  end
  it 'has #last' do
    expect([1, 2, 3].last).to eq(3)
  end
  it 'has #last_option' do
    some = [1, 2, 3].last_option
    expect(some.get).to eq(3)
    none = ([]).last_option
    expect(none.is_defined).to be_falsey
  end
  it 'has #lift' do
    seq_lift = [1, 2, 3].lift
    expect(seq_lift.apply(0).get).to eq(1)
    expect(seq_lift.apply(1).get).to eq(2)
    expect(seq_lift.apply(2).get).to eq(3)
    expect(seq_lift.apply(3).is_defined).to be_falsey
    expect(seq_lift.call(0).get).to eq(1)
    expect(seq_lift.call(1).get).to eq(2)
    expect(seq_lift.call(2).get).to eq(3)
    expect(seq_lift.call(3).is_defined).to be_falsey
  end
  it 'has #map' do
    expect([1, 2, 3].map { |i| i + i }.to_a).to eq([2, 4, 6])
  end
  it 'has #max' do
    expect(one_to_five_shuffled.max).to eq(5)
  end
  it 'has #min' do
    expect(one_to_five_shuffled.min).to eq(1)
  end
  it 'has #mk_string' do
    expect(one_to_five.mk_string).to eq('12345')
    expect(one_to_five.mk_string(',')).to eq('1,2,3,4,5')
    expect(one_to_five.mk_string('^', ',', '$')).to eq('^1,2,3,4,5$')
    begin
      expect(one_to_five.mk_string('a', 'b')).to eq(nil)
    rescue ArgumentError
    end
    expect(one_to_five.mk_string('^', ',', '$', 'zzz')).to eq('^1,2,3,4,5$')
  end
  it 'has #non_empty' do
    expect(one_to_five.non_empty).to be_truthy
    expect([].non_empty).to be_falsey
  end
  it 'has #partition' do
    expect([5, 2, 3, 1, 4, 2, 3].partition { |i| i < 3 }.to_a).to eq([[2, 1, 2], [5, 3, 4, 3]])
  end
  it 'has #patch' do
    expect([5, 2, 3, 1, 4, 2, 3].patch(3, [111, 222], 3).to_a).to eq([5, 2, 3, 111, 222, 3])
  end
  it 'has #reverse' do
    expect([1, 2, 3].reverse.to_a).to eq([3, 2, 1])
  end
  it 'has #reverse_map' do
    expect([1, 2, 3].reverse_map { |i| i + i }.to_a).to eq([6, 4, 2])
  end
  it 'has #same_elements' do
    expect([1, 2, 3].same_elements([1, 2, 3])).to be_truthy
    expect([1, 2, 3].same_elements([1, 3, 2])).to be_falsey
    expect([1, 2, 3].same_elements([1, 2])).to be_falsey
  end
  it 'has #scan_left' do
    expect([1, 2, 3].scan_left(1) { |a, b| a + b }.to_a).to eq([1, 2, 4, 7])
  end
  it 'has #scan_right' do
    expect([1, 2, 3].scan_right(1) { |a, b| a + b }.to_a).to eq([7, 6, 4, 1])
  end
  it 'has #slice' do
    # the already defined method is called
    #[1,2,3,4,5].slice(1,1).to_a.should eq([])
    #[1,2,3,4,5].slice(1,2).to_a.should eq([2])
    #[1,2,3,4,5].slice(1,3).to_a.should eq([2,3])
    #[1,2,3,4,5].slice(1,4).to_a.should eq([2,3,4])
    expect([1, 2, 3, 4, 5].slice(1, 1)).to eq([2])
    expect([1, 2, 3, 4, 5].slice(1, 2)).to eq([2, 3])
    expect([1, 2, 3, 4, 5].slice(1, 3)).to eq([2, 3, 4])
    expect([1, 2, 3, 4, 5].slice(1, 4)).to eq([2, 3, 4, 5])
  end
  it 'has #sliding' do
    expect([1, 2, 3, 4, 5].sliding(2).to_a).to eq([[1, 2], [2, 3], [3, 4], [4, 5]])
  end
  it 'has #sort_with' do
    expect([1, 3, 2, 4, 5].sort_with { |a, b| b <=> a }.to_a).to eq([5, 4, 3, 2, 1])
  end
  it 'has #span' do
    expect([1, 2, 3, 2, 1].span { |i| i < 3 }.to_a).to eq([[1, 2], [3, 2, 1]])
  end
  it 'has #split_at' do
    expect([1, 2, 3, 2, 1].split_at(3).to_a).to eq([[1, 2, 3], [2, 1]])
  end
  it 'has #starts_with' do
    expect([1, 2, 3].starts_with([1])).to be_truthy
    expect([1, 2, 3].starts_with([1, 2])).to be_truthy
    expect([1, 2, 3].starts_with([1, 2, 3])).to be_truthy
    expect([1, 2, 3].starts_with([1, 2, 3, 4])).to be_falsey
    expect([1, 2, 3].starts_with([2, 3])).to be_falsey
    expect([1, 2, 3].starts_with([4, 1, 2, 3])).to be_falsey
  end
  it 'has #sum' do
    expect([1, 2, 3].sum).to eq(6)
  end
  it 'has #tail' do
    expect([1, 2, 3].tail.to_a).to eq([2, 3])
    expect([].tail.to_a).to eq([])
  end
  it 'has #take' do
    expect([1, 2, 3].take(0).to_a).to eq([])
    expect([1, 2, 3].take(1).to_a).to eq([1])
    expect([1, 2, 3].take(2).to_a).to eq([1, 2])
    expect([1, 2, 3].take(3).to_a).to eq([1, 2, 3])
    expect([1, 2, 3].take(4).to_a).to eq([1, 2, 3])
  end
  it 'has #take_right' do
    expect([1, 2, 3].take_right(0).to_a).to eq([])
    expect([1, 2, 3].take_right(1).to_a).to eq([3])
    expect([1, 2, 3].take_right(2).to_a).to eq([2, 3])
    expect([1, 2, 3].take_right(3).to_a).to eq([1, 2, 3])
    expect([1, 2, 3].take_right(4).to_a).to eq([1, 2, 3])
  end
  it 'has #take_while' do
    expect([5, 3, 2, 4, 1].take_while { |e| e > 2 }.to_a).to eq([5, 3])
  end
  it 'has #union' do
    expect([1, 2, 3].union([2, 3, 4]).to_a).to eq([1, 2, 3, 2, 3, 4])
  end
  it 'has #updated' do
    expect([1, 2, 3].updated(1, 999).to_a).to eq([1, 999, 3])
  end
  it 'has #zip' do
    # the already defined method is called
    #[1,2,3].zip([2,3]).to_a.should eq([[1,2],[2,3]])
    #[1,2,3].zip([2,3,4]).to_a.should eq([[1,2],[2,3],[3,4]])
    #[1,2,3].zip([2,3,4,5]).to_a.should eq([[1,2],[2,3],[3,4]])
    expect([1, 2, 3].zip([2, 3])).to eq([[1, 2], [2, 3], [3, nil]])
    expect([1, 2, 3].zip([2, 3, 4])).to eq([[1, 2], [2, 3], [3, 4]])
    expect([1, 2, 3].zip([2, 3, 4, 5])).to eq([[1, 2], [2, 3], [3, 4]])
  end
  it 'has #zip_with_index' do
    expect([].zip_with_index.to_a).to eq([])
    expect([1, 2, 3].zip_with_index.to_a).to eq([[1, 0], [2, 1], [3, 2]])
  end

end
