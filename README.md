# Month::Serializer

**Integer Serialization Plugin for [Month Gem](https://github.com/timcraft/month)**

Allows you to convert [`Month` objects](https://github.com/timcraft/month/blob/master/lib/month.rb) to `Integer`, and vice versa.  This is useful for serializing Months into other data structures, like `String`, or to pass values in `JSON`, or send as parameters to Resque / Sidekiq jobs (which parameters are [only compatible with simple JSON data types](https://github.com/mperham/sidekiq/wiki/The-Basics#client).  Neither `Date` or `Month` can serialize properly to Resque/Sidekiq jobs.

| Project                 |  Month::Serializer |
|------------------------ | ----------------------- |
| gem name                |  [month-serializer](https://rubygems.org/gems/month-serializer) |
| license                 |  [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT) |
| download rank           |  [![Downloads Today](https://img.shields.io/gem/rd/month-serializer.svg)](https://github.com/pboling/month-serializer) |
| version                 |  [![Version](https://img.shields.io/gem/v/month-serializer.svg)](https://rubygems.org/gems/month-serializer) |
| dependencies            |  [![Depfu](https://badges.depfu.com/badges/272ce0df3bc6df5cbea9354e2c3b65af/count.svg)](https://depfu.com/github/pboling/month-serializer?project_id=5614) |
| continuous integration  |  [![Build Status](https://travis-ci.org/pboling/month-serializer.svg?branch=master)](https://travis-ci.org/pboling/month-serializer) |
| test coverage           |  [![Test Coverage](https://api.codeclimate.com/v1/badges/50241bf0d9c78bcce69e/test_coverage)](https://codeclimate.com/github/pboling/month-serializer/test_coverage) |
| maintainability         |  [![Maintainability](https://api.codeclimate.com/v1/badges/50241bf0d9c78bcce69e/maintainability)](https://codeclimate.com/github/pboling/month-serializer/maintainability) |
| code triage             |  [![Open Source Helpers](https://www.codetriage.com/pboling/month-serializer/badges/users.svg)](https://www.codetriage.com/pboling/month-serializer) |
| homepage                |  [on Github.com][homepage], [on Railsbling.com][blogpage] |
| documentation           |  [on RDoc.info][documentation] |
| Spread ~♡ⓛⓞⓥⓔ♡~      |  [🌍 🌎 🌏][peterboling], [🍚][refugees], [➕][gplus], [👼][angellist], [🐛][topcoder], [:shipit:][coderwall], [![Tweet Peter](https://img.shields.io/twitter/follow/galtzo.svg?style=social&label=Follow)][twitter] |

### Why use Month instead of Date or Time?

- Month is lighter weight.
- There are many situations where having Months incrementable by 1 is useful
  - e.g. Directly mappable to iteration index
- It facilitates month-based math.
- Adding a day when a day is not relevant, such as for data with a 1 month resolution, can result in very overcomplicated systems that try to work around or ignore the stray days.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'month-serializer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install month-serializer

## Usage

Add this to the bootstrapping process of your app, somewhere after the [`month` gem](https://github.com/timcraft/month) is loaded.
In Rails, `config/initializers/month-serializer.rb` would be perfect, but Rails is not required.

````ruby
Month.send(:include, Month::Serializer)
````

This spec below, copied from the actual test suite, makes usage pretty clear.  Note how the serialized Months as integer increment by one.  If you think about counting time by months this makes sense.  We often speak this way about babies, an 18 month old, or 24 month old.
  
How old is the Common Era right now?  About 24.2k months!  Is a millenimonth, millimes, or kilomonth, a thing?  The Common Era is roughly 24 kilomonths old. 😆  And Neanderthal man went extinct about 471 kilomonths ago.

```ruby
    {
        -471359 => Month.new(-39280, 1),  # hist: Extinction of Neanderthal
        24201 => Month.new(2016, 9),
        24202 => Month.new(2016, 10),
        # ...
        24214 => Month.new(2017, 10),
        24215 => Month.new(2017, 11),
        # ...
        24227 => Month.new(2018, 11),
        24228 => Month.new(2018, 12)
    }.each do |k, v|
           context "#{k} => #{v}" do
             it "Month converts to #{k}" do
               expect(v.to_i).to eq(k)          # to_i is added by this gem!
             end
             context 'round trip' do
               it "can load #{k} to #{v}" do
                 expect(Month.load(k)).to eq(v) # load is added by this gem!
               end
               it "can dump #{v} to #{k}" do
                 expect(Month.dump(v)).to eq(k) # dump is added by this gem!
               end
             end
           end
         end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Authors

[Peter H. Boling][peterboling] of [Rails Bling][railsbling] is the author.

## Contributors

See the [Network View](https://github.com/pboling/month-serializer/network) and the [CHANGELOG](https://github.com/pboling/month-serializer/blob/master/CHANGELOG.md)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
6. Create new Pull Request

Bug reports and pull requests are welcome on GitHub at https://github.com/pboling/anonymous_active_record. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the AnonymousActiveRecord project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/pboling/anonymous_active_record/blob/master/CODE_OF_CONDUCT.md).

## Versioning

This library aims to adhere to [Semantic Versioning 2.0.0][semver].
Violations of this scheme should be reported as bugs. Specifically,
if a minor or patch version is released that breaks backward
compatibility, a new version should be immediately released that
restores compatibility. Breaking changes to the public API will
only be introduced with new major versions.

As a result of this policy, you can (and should) specify a
dependency on this gem using the [Pessimistic Version Constraint][pvc] with two digits of precision.

For example in a `Gemfile`:

    gem 'month-serializer', '~> 1.0', group: :test

or in a `gemspec`

    spec.add_development_dependency 'month-serializer', '~> 1.0'

## Legal

* MIT License - See [LICENSE][license] file in this project [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT) 

* Copyright (c) 2018 [Peter H. Boling][peterboling] of [Rails Bling][railsbling]

[semver]: http://semver.org/
[pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[documentation]: http://rdoc.info/github/pboling/month-serializer/frames
[homepage]: https://github.com/pboling/month-serializer
[blogpage]: http://www.railsbling.com/tags/month-serializer/
[license]: LICENSE
[railsbling]: http://www.railsbling.com
[peterboling]: https://about.me/peter.boling
[refugees]: https://www.crowdrise.com/helprefugeeswithhopefortomorrowliberia/fundraiser/peterboling
[gplus]: https://plus.google.com/+PeterBoling/posts
[topcoder]: https://www.topcoder.com/members/pboling/
[angellist]: https://angel.co/peter-boling
[coderwall]: http://coderwall.com/pboling
[twitter]: http://twitter.com/galtzo
