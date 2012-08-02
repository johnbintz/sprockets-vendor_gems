require 'sprockets'
require 'rubygems'

module ::Sprockets
  module VendorGems
    class << self
      attr_accessor :default_types
    end

    self.default_types = %w{javascripts stylesheets images}
  end

  def self.find_gem_vendor_paths(options = {})
    options = { :paths => %w{vendor lib app} }.merge(options)

    for_types = [ options[:for] || ::Sprockets::VendorGems.default_types ].flatten

    paths = []

    GemEnvironment.each do |gemspec|
      options[:paths].product(for_types).each do |base_dir, type|
        path = File.join(gemspec.gem_dir, base_dir, "assets", type.to_s)

        paths << path if File.directory?(path)
      end
    end

    paths
  end

  class EnvironmentWithVendoredGems < Environment
    def initialize(*args)
      super(*args)

      extend_with_vendored_gems
    end
  end

  class Environment
    def extend_with_vendored_gems
      Sprockets.find_gem_vendor_paths.each { |path| append_path(path) }
    end
  end

  class GemEnvironment
    extend Enumerable

    def self.gemspecs
      Gem.loaded_specs.map(&:last)
    end

    def self.each(&block)
      return enum_for(:each) unless block_given?

      gemspecs.each {|spec| yield spec }
    end
  end
end

