# -*- encoding: utf-8 -*-

require 'scaruby'

describe Scaruby::ConcurrentOps do
  it 'has #spawn' do
    is_done = false
    spawn do
      sleep 0.3
      is_done = true
    end
    is_done.should eq(false)
    sleep 0.5
    is_done.should eq(true)
  end
  it 'has #future' do
    is_done = false
    future = future {
      sleep 0.3
      is_done = true
      sleep 0.5
      :ok
    }
    is_done.should eq(false)
    sleep 0.5
    is_done.should eq(true)
    future.get.should eq(:ok)
    is_done.should eq(true)
  end
end

