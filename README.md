# Sunlight::Congress

[![Build Status](https://travis-ci.org/steveklabnik/sunlight-congress.svg?branch=master)](https://travis-ci.org/steveklabnik/sunlight-congress)

*The API this uses has been shutdown.* Follow [this post](https://www.propublica.org/nerds/congress-api-bill-subjects-personal-explanations-and-sunsetting-sunlight) for more information.

This is a wrapper for the [Sunlight Foundation's Congress API](http://sunlightlabs.github.io/congress/).

It is very much a work in progress, and only supports part of the API. Any
assistance with implementing extra calls would be appreciated!

## Installation

Add this line to your application's Gemfile:

    gem 'sunlight/congress'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sunlight-congress

## Usage

The first thing you need to do is set up an API key. You can apply for one
[here](http://services.sunlightlabs.com/accounts/register/). They're free and
have no usage limits.

Once you have your key:

```ruby
require 'sunlight-congress'

Sunlight::Congress.api_key = "lolthisisnotarealkey"
```

Then, you can build various objects relating to the API. For example:

```ruby
Sunlight::Congress::Legislator.by_zipcode("90210")
=> [#<Sunlight::Congress::Legislator:0x007fad4a2f67b0 @first_name="Henry"...
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
