# -*- encoding: utf-8 -*-

module Scaruby
  class AppliableProc < Proc
    alias_method :apply, :call
  end
end

