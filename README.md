# Sinatra::RoutingHelpers

A simple little set of helpers for getting around in Sinatra.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra-routing-helpers', :required => 'sinatra/routing-helpers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-routing-helpers

## Usage

Classic apps are all set and modular apps can simply:

    register Sinatra::RoutingHelpers

Either way, you can configure the blacklist of parameters like so:

    set :params_blacklist, [:password, :_csrf, :ip]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
