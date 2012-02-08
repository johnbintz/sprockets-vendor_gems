require 'sprockets'
require 'rubygems'

module ::Sprockets
  class << self
    def find_gem_vendor_paths(options = {})
      for_types = [ options[:for] || [ 'javascripts', 'stylesheets' ] ].flatten

      paths = []

      Gem::Specification.each do |gemspec|
        %w{vendor lib app}.product(for_types).each do |base_dir, type|
          path = File.join(gemspec.gem_dir, base_dir, "assets", type.to_s)

          paths << path if File.directory?(path)
        end
      end

      paths
    end
  end

  class EnvironmentWithVendoredGems < Environment
    def initialize(*args)
      super(*args)

      Sprockets.find_gem_vendor_paths.each { |path| append_path(path) }
    end
  end
end

