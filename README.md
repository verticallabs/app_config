# AppConfig

AppConfig is a bare-bones method of organizing all your .yml data for a Rails app.

## Installation

Add this line to your application's Gemfile:

    gem 'app_config'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install app_config

## Usage

Let's say I have config/redis.yml:

    development: 
      queue_server:
        host: qd-dev.blah.com
        password: alskdjf
    test: 
      queue_server:
        host: qd-test.blah.com
        password: asldkfjalskfjd
    production:
      queue_server:
        host: qd.blah.com
        password: alskdfjlaskjdflaksjf

In an initializer

    AppConfig.load(:redis, :mongoid, :etc) 

Or with a block

    AppConfig.load(:redis, :mongoid, :etc) do |config|
      redises = config[:redis].values.map {|r| Redis.new(r) }
      config[:redis][:servers] = Hash[config[:redis].keys.zip(redises)]
    end

Once it is loaded you can access the data at:

    AppConfig.redis.queue_server.password

It will assume that the top level keys in your yml files are the Rails environments, and only load the matching one.

Any information which is local to the developer should be kept in config/development.yml, which is only loaded in development environment,
and which will override any settings already loaded.  This can also be done for test environment.  Note that the top-level keys in the development.yml
are not the environments, but the setting files that they're overriding.  Thus:

    redis:
      queue_server:
        host: mylocalhost

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
