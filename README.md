# HashExt

[![Gem Version](https://badge.fury.io/rb/hash_ext.svg)](https://rubygems.org/gems/hash_ext)
[![CI](https://github.com/gabynaiman/hash_ext/actions/workflows/ci.yml/badge.svg)](https://github.com/gabynaiman/hash_ext/actions/workflows/ci.yml)
[![Coverage Status](https://coveralls.io/repos/gabynaiman/hash_ext/badge.svg?branch=master)](https://coveralls.io/r/gabynaiman/hash_ext?branch=master)
[![Code Climate](https://codeclimate.com/github/gabynaiman/hash_ext.svg)](https://codeclimate.com/github/gabynaiman/hash_ext)

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

### Accessible

```ruby
hash = Hash::Accessible.new key_1: 1, key_2: { key_3: 3 }

hash[:key_1] # => 1
hash.key_1   # => 1

hash[:key_2] # => {key_3: 3}
hash.key_2   # => {key_3: 3}

hash[:key_2][:key_3] # => 3
hash.key_2.key_3     # => 3 
```

### Builder

```ruby
hash = Hash::Builder.build do |h|
  h.key_1 1
  h.key_2 do
    h.key_3 3
  end
end

hash # => {key_1: 1, key_2: {key_3: 3}}
```

### Normalized

```ruby
hash = Hash::Normalized.new { |key| key.upcase }

hash['key_1'] = 1

hash['key_1'] # => 1
hash['KEY_1'] # => 1
```

### Indifferent

```ruby
hash = Hash::Indifferent.new

hash['key_1'] = 1
hash[:key_2]  = 2

hash['key_1'] # => 1
hash[:key_1]  # => 1

hash['key_2'] # => 2
hash[:key_2]  # => 2
```

### Sorted

```ruby
hash = Hash::Sorted.asc { |k,v| k.to_s }

hash[:c] = 1
hash[:b] = 2
hash[:a] = 3

hash.keys # => [:a, :b, :c]
```

### Nested
```ruby
hash = Hash::Nested.new

hash[:level_1][:level_2][:level_3] = 'value'

hash # => {level_1: {level_2: {level_3: 'value'}}}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabynaiman/hash_ext.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

