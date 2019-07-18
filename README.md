# FullJoin

provides full join for Array

It looks like Array#zip, but detect same value and gather them like a Full Join. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'full_join'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install full_join

## Usage

```ruby
Hoge = Struct.new(:id, keyword_init: true)

array1 = [Hoge.new(id: 1), Hoge.new(id: 2), Hoge.new(id: 3)]
array2 = [Hoge.new(id: 2), Hoge.new(id: 3), Hoge.new(id: 4)]

array1.full_join(array2) #=> [
  [#<struct Hoge id=1>, nil]
  [#<struct Hoge id=2>, #<struct Hoge id=2>]
  [#<struct Hoge id=3>, #<struct Hoge id=3>]
  [nil, #<struct Hoge id=4>]
]
```

also, like this

```ruby
Hoge = Struct.new(:id, :name, keyword_init: true)
Fuga = Struct.new(:id, :name, keyword_init: true)

array1 = [
  Hoge.new(id: 1, name: "AAA"),
  Hoge.new(id: 2, name: "BBB"),
  Hoge.new(id: 3, name: "CCC")
]
array2 = [
  Fuga.new(id: 101, name: "BBB"),
  Fuga.new(id: 102, name: "CCC"),
  Fuga.new(id: 103, name: "DDD")
]

array1.full_join(array2, &:name) #=> [
  [Hoge.new(id: 1, name: "AAA"), nil],
  [Hoge.new(id: 2, name: "BBB"), Fuga.new(id: 101, name: "BBB")],
  [Hoge.new(id: 3, name: "CCC"), Fuga.new(id: 102, name: "CCC")],
  [nil, Fuga.new(id: 103, name: "DDD")]
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/naari3/full_join.
