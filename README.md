# Get at available assets in loaded gems in Sprockets

Either get the list of asset paths:

``` ruby
require 'sprockets-vendor_gems'

env = Sprockets::Environment.new('.')
Sprockets.find_gem_vendor_paths(:for => :javascript).each do |path|
  env.append_path path
end
```

or get an Environment with those paths in there already:
``` ruby
require 'sprockets-vendor_gems'

env = Sprockets::EnvironmentWithVendoredGems.new('.')
```

Yeah!

## Installation

Add this line to your application's Gemfile:

    gem 'sprockets-vendor_gems'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sprockets-vendor_gems

