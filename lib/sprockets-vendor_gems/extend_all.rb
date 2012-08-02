require 'sprockets-vendor_gems'

module ::Sprockets
  class Environment
    alias :_initialize :initialize

    def initialize(*args)
      _initialize(*args)

      self.extend_with_vendored_gems
    end
  end
end

