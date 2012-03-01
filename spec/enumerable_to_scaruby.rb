# -*- encoding: utf-8 -*-

require 'enumerable_to_scaruby'

describe Enumerable do
  it 'has #flat_map' do
    flatten = [[1,2],[3],[4,5]].flat_map {|i| i }.to_a
    flatten.should eq([1,2,3,4,5])
  end
  it 'has #count' do
    result = [1,2,3,4,5].count {|i| i > 2 }
    result.should eq(3)
  end
  it 'has #diff' do
    result = [1,2,3].diff([2,3,4]).to_a
    result.should eq([1])
  end
  it 'has #distinct' do
    result = [1,2,4,1,3,3,3,2,4,1].distinct.to_a
    result.should eq([1,2,4,3])
  end
end

