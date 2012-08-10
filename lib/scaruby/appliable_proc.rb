# -*- encoding: utf-8 -*-

require 'scaruby/function'

module Scaruby
  class AppliableProc < Proc
    include Function
    alias_method :apply, :call
  end
end

