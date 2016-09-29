# HashExt

[![Gem Version](https://badge.fury.io/rb/hash_ext.svg)](https://rubygems.org/gems/hash_ext)
[![Build Status](https://travis-ci.org/gabynaiman/hash_ext.svg?branch=master)](https://travis-ci.org/gabynaiman/hash_ext)
[![Coverage Status](https://coveralls.io/repos/gabynaiman/hash_ext/badge.svg?branch=master)](https://coveralls.io/r/gabynaiman/hash_ext?branch=master)
[![Code Climate](https://codeclimate.com/github/gabynaiman/hash_ext.svg)](https://codeclimate.com/github/gabynaiman/hash_ext)
[![Dependency Status](https://gemnasium.com/gabynaiman/hash_ext.svg)](https://gemnasium.com/gabynaiman/hash_ext)

Hash extensions without monkey patching

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hash_ext'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hash_ext

## Usage

### Available classes

```ruby
Hash::Accessible
Hash::Builder
Hash::Indifferent
Hash::Sorted
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabynaiman/hash_ext.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

