require "phoneparse/version"

# main module definition
module Phoneparse
  # load gem classes
  autoload :Core, 'phoneparse/core'
  autoload :Phone, 'phoneparse/phone'

  extend Module.new {
    include Core
  }
end
