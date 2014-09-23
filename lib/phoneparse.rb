require "phoneparse/version"
require "countries"
require "phonelib"
require "phony"
require "geocoder"

# main module definition
module Phoneparse
  # load gem classes
  autoload :Core, 'phoneparse/core'
  autoload :Phone, 'phoneparse/phone'

  extend Module.new {
    include Core
  }
end
