<div align="center">

![Imgur](https://i.imgur.com/GVZPW02.png)

# Eloquant

#### A wrapper for Oracle Eloqua's [REST API](https://docs.oracle.com/cloud/latest/marketingcs_gs/OMCAB/index.htm)

[![Build Status](https://travis-ci.org/jstumbaugh/eloquant.svg?branch=master)](https://travis-ci.org/jstumbaugh/eloquant)
[![Test Coverage](https://api.codeclimate.com/v1/badges/66148a40fdaa015d4006/test_coverage)](https://codeclimate.com/github/jstumbaugh/eloquant/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/66148a40fdaa015d4006/maintainability)](https://codeclimate.com/github/jstumbaugh/eloquant/maintainability)
[![Gem Version](https://badge.fury.io/rb/eloquant.svg)](https://badge.fury.io/rb/eloquant)

</div>

## Usage

### Client Instantiation

Eloquant uses Basic HTTP Authentication for retrieving data from Eloqua. You
need to supply the username, site/company name, and password when initializing
the client.

```ruby
Eloquant::Client.new(username: "username", sitename: "mycompany", password: "password")
```

Alternatively, you can store these variables in your environment file:

```
ELOQUA_USERNAME='username'
ELOQUA_SITENAME='mycompany'
ELOQUA_PASSWORD='password'
```

---------

### Available Endpoints

#### Accounts

- `describe_accounts` - Return the list of fields for an Account
- `describe_accounts_csv` - Return the list of fields for an Account as a CSV formatted string

#### Activities

- `describe_activities` - Return the list of fields for an Activity
- `describe_activities_csv` - Return the list of fields for an Activity as a CSV formatted string

#### Campaign Responses

- `describe_campaign_responses` - Return the list of fields for a Campaign Response
- `describe_campaign_responses_csv` - Return the list of fields for a Campaign Response as a CSV formatted string

#### Campaigns

- `describe_campaigns` - Return the list of fields for a Campaign
- `describe_campaigns_csv` - Return the list of fields for a Campaign as a CSV formatted string

#### Contacts

- `describe_contacts` - Return the list of fields for a Contact
- `describe_contacts_csv` - Return the list of fields for a Contact as a CSV formatted string

#### Custom Objects

- No describe is available for Custom Objects

#### Events

- No describe is available for Events

#### External Activities

- No describe is available for External Activities

#### Opportunities

- `describe_opportunities` - Return the list of fields for an Opportunity
- `describe_opportunities_csv` - Return the list of fields for an Opportunity as a CSV formatted string

-----------

## Installation

Add this line to your application's Gemfile:

```ruby
gem "eloquant"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eloquant

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jstumbaugh/eloquant. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Eloquant project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jstumbaugh/eloquant/blob/master/CODE_OF_CONDUCT.md).

## Releasing to [RubyGems](https://rubygems.org/gems/eloquant)

Use the `bin/release` script to build, push, and tag this gem.
