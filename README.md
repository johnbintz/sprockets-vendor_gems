# Get at available assets in loaded gems in Sprockets

Who says you need Rails Engines to use the vendored assets in gems? All you need is
`sprockets-vendor_gems`. Use those cool vendored JavaScript & CSS gems in anything!

The easiest way? Punch Sprockets right in the duck!

``` ruby
require 'sprockets-vendor_gems/extend_all'
```

So, for instance, in Sinatra with [sinatra-sprockets](https://github.com/amarshall/sinatra-sprockets):

``` ruby
# config.ru

require 'sinatra/base'
require 'sprockets-vendor_gems/extend_all'
require 'sinatra/sprockets'

class MyApp < Sinatra::Base
  register Sinatra::Sprockets

  get '/' do
    "hi"
  end
end

map "/assets" do
  run Sinatra::Sprockets.environment
end

run MyApp

```

*Every* `Sprockets::Environment` instance now has every vendored gems asset path added!
By default, that's the `javascripts`, `stylesheets`, and `images` directories. Need more?

``` ruby
Sprockets::VendorGems.default_types << "coolthings"
```

Do that before any `Sprockets::Environment`s get instantiated.

Want more manual control? Either get the list of asset paths:

``` ruby
require 'sprockets-vendor_gems'

env = Sprockets::Environment.new('.')
Sprockets.find_gem_vendor_paths(:for => :javascript).each do |path|
  env.append_path path
end
```

or, instead of duck punching all of Sprockets, get an Environment with those paths in there already:

``` ruby
require 'sprockets-vendor_gems'

env = Sprockets::EnvironmentWithVendoredGems.new
```

Yeah!

You may have to futz a bit with `require` and fake classes for particular gems, especially if they really
rely on Rails to get their job done.
