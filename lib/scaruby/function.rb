# -*- encoding: utf-8 -*-

require 'scaruby/appliable_proc'

module Scaruby
  module Function

    def compose(g)
      Proc.new { |*args| self.call(g.call(*args)) }
    end

    def and_then(g)
      Proc.new { |*args| g.call(self.call(*args)) }
    end

  end
end
