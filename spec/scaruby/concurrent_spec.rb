# -*- encoding: utf-8 -*-

require 'scaruby'

describe Scaruby::ConcurrentOps do
  it 'has #spawn' do
    is_done = false
    spawn do
      sleep 0.3
      is_done = true
    end
    expect(is_done).to be_falsey
    sleep 0.5
    expect(is_done).to be_truthy
  end
  it 'has #future' do
    is_done = false
    future = future {
      sleep 0.3
      is_done = true
      sleep 0.5
      :ok
    }
    expect(is_done).to be_falsey
    sleep 0.5
    expect(is_done).to be_truthy
    expect(future.get).to eq(:ok)
    expect(is_done).to be_truthy
  end
end

