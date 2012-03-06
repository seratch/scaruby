# -*- encoding: utf-8 -*-

require 'scaruby'

describe Scaruby::ConcurrentOps do
  it 'has #spawn' do
    is_done = false
    spawn do
      sleep 2 
      is_done = true
    end
    is_done.should eq(false)
    sleep 3
    is_done.should eq(true)
  end
  it 'has #future' do
    is_done = false
    future = future {
      sleep 2
      is_done = true
      :ok
    }
    is_done.should eq(false)
    sleep 1 
    future.get.should eq(:ok)
    is_done.should eq(true)
  end
end

