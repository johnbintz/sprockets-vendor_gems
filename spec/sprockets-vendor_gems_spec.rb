require 'spec_helper'

describe Sprockets do
  include FakeFS::SpecHelpers

  describe '.find_gem_vendor_paths' do
    let(:gem_dir) { "dir" }
    let(:gemspec) { stub(:gem_dir => gem_dir) }

    let(:paths) do
      %w{vendor lib app}.collect do |dir|
        File.join(gem_dir, dir, 'assets/javascripts')
        File.join(gem_dir, dir, 'assets/stylesheets')
      end
    end

    before do
      paths.each { |path| FileUtils.mkdir_p path }

      Sprockets::GemEnvironment.stubs(:each).yields(gemspec)
    end

    subject { described_class.find_gem_vendor_paths }

    it { should =~ paths }
  end
end

describe Sprockets::EnvironmentWithVendoredGems do
  let(:env) { described_class.new }
  let(:path) { 'path' }

  before do
    Sprockets.expects(:find_gem_vendor_paths).returns([ path ])

    described_class.any_instance.expects(:append_path).with(path)
  end

  it 'should work' do
    env
  end
end
