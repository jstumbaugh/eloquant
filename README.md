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

## Available Endpoints

### [Application API](https://docs.oracle.com/cloud/latest/marketingcs_gs/OMCAB/Developers/RESTAPI/REST-API.htm) (Rest API)

#### Accounts

- `describe_accounts` - Return the list of fields for an Account
- `describe_accounts_csv` - Return the list of fields for an Account as a CSV formatted string
- `number_of_accounts` - Return the number of Accounts in the Eloqua database
- `get_account(eloqua_external_id)` - Query for a single Account given an Account's External ID (`CompanyIDExt`)

#### Activities

- `describe_activities` - Return the list of fields for an Activity
- `describe_activities_csv` - Return the list of fields for an Activity as a CSV formatted string

#### Campaign Responses

- `describe_campaign_responses` - Return the list of fields for a Campaign Response
- `describe_campaign_responses_csv` - Return the list of fields for a Campaign Response as a CSV formatted string

#### Campaigns

- `describe_campaigns` - Return the list of fields for a Campaign
- `describe_campaigns_csv` - Return the list of fields for a Campaign as a CSV formatted string
- `number_of_campaigns` - Return the number of Campaigns in the Eloqua database
- `get_campaigns(page:, depth:, count:)` - Return Campaigns given the parameters

#### Contacts

- `describe_contacts` - Return the list of fields for a Contact
- `describe_contacts_csv` - Return the list of fields for a Contact as a CSV formatted string
- `number_of_contacts` - Return the number of Contacts in the Eloqua database
- `get_contact(eloqua_external_id)` - Query for a single Contact given a Contact's External ID (`ContactIDExt`)

#### Opportunities

- `describe_opportunities` - Return the list of fields for an Opportunity
- `describe_opportunities_csv` - Return the list of fields for an Opportunity as a CSV formatted string

### [Bulk API](https://docs.oracle.com/cloud/latest/marketingcs_gs/OMCAB/Developers/BulkAPI/bulk-API.htm)

The Bulk API works a little differently than the REST API. [This post](https://docs.oracle.com/cloud/latest/marketingcs_gs/OMCAB/Developers/BulkAPI/Tutorials/Export.htm)
does a fantastic job of explaining it.

First, it works by creating an "export" in Eloqua given a set of parameters.
The parameters are as follows:

- `name` (required) - The name of your export
- `fields` (required) - A hash containing the field mappings from a custom name to an Eloqua attribute
  - Ex:
```ruby
fields = {
  # Custom Name       => "Name in Eloqua"
  :contact_id         => "{{Contact.Id}}",
  :contact_first_name => "{{Contact.FirstName}}",
  :contact_last_name  => "{{Contact.LastName}}",
  :contact_created_at => "{{Contact.CreatedAt}}",
}
```
- `filter` (optional for most, required for Activities) - The [filters](https://docs.oracle.com/cloud/latest/marketingcs_gs/OMCAB/Developers/BulkAPI/Tutorials/Filtering.htm?cshid=BulkFiltering) are used to narrow down your result
  - Ex: Activities require a filter based on the Activity Type.
```ruby
# All Web Visit Activities
filter = "'{{Activity.Type}}' = 'WebVisit'"
# All Email Send Activities after Jan 1, 2018
filter = "'{{Activity.Type}}' = 'EmailSend' AND '{{Activity.CreatedAt}}' >= '2018-01-01'"
```

Each of the Bulk API endpoints take these three named parameters.

After creating a bulk export, the URI of the sync from Eloqua is returned. You
can use this URI to query for the data.

```ruby
# Example 1: Get all of the Form Submit activities in a given time frame
client.create_bulk_activity_export(
  name: "Eloquant Bulk Activity Export Example",
  filter: "'{{Activity.Type}}' = 'FormSubmit'",
  fields: {
    id:            "{{Activity.Id}}",
    activity_date: "{{Activity.CreatedAt}}",
    contact_id:    "{{Activity.Contact.Id}}",
  },
)
#=> "/syncs/2010234"
sync_uri = "/syncs/2010234"

client.get_export_data(sync_uri)
#=> {
#    :totalResults => 49997,
#    :limit        => 1000,
#    :offset       => 0,
#    :count        => 1000,
#    :hasMore      => true,
#    :items        => [
#      {
#        :id            => "1",
#        :activity_date => "2018-11-02 13:25:26.203",
#        :contact_id    => "438294"
#      },
#      {
#        :id            => "2",
#        :activity_date => "2018-11-02 13:25:26.203",
#        :contact_id    => "982340"
#      },
#      ...
#    ]
#  }

# To get the next 1,000 results
client.get_export_data(sync_uri, offset: 1000)
#=> {
#    :totalResults => 49997,
#    :limit        => 1000,
#    :offset       => 1000,
#    :count        => 1000,
#    :hasMore      => true,
#    :items        => [
#      {
#        :id            => "1001",
#        :activity_date => "2018-11-02 1:22:34.213",
#        :contact_id    => "138573"
#      },
#      {
#        :id            => "1002",
#        :activity_date => "2018-11-02 15.24.12.323",
#        :contact_id    => "943209"
#      },
#      ...
#    ]
#  }

# To get the last of the results. Note the `count` and `hasMore` keys in response
client.get_export_data(sync_uri, offset: 49000)
#=> {
#    :totalResults => 49997,
#    :limit        => 1000,
#    :offset       => 49000,
#    :count        => 997,
#    :hasMore      => false,
#    :items        => [
#      ...
#      {
#        :id            => "49996",
#        :activity_date => "2018-11-02 13:25:26.203",
#        :contact_id    => "123456"
#      },
#      {
#        :id            => "49997",
#        :activity_date => "2018-11-02 13:25:26.203",
#        :contact_id    => "098439"
#      }
#    ]
#  }
```
- `totalResults` shows how many items in the database matched your query
- `limit` shows the number of items this response is limited to return
- `offset` shows the offset in which items in the query are paged through
  - An offset of 0 would return results 1 - 1,000. An offset of 1,000 would
    return results 1,001 - 2000
- `count` shows the number of items returned in this response
- `hasMore` is a boolean denoting if there are more results to page through

#### Accounts

- `create_bulk_account_export(params)` - Create a bulk Account export with the input parameters defined above
- `list_account_exports` - List the created Account exports from Eloqua

#### Activities

- `create_bulk_activity_export(params)` - Create a bulk Activity export with the input parameters defined above
- `list_activity_exports` - List the created Activity exports from Eloqua

#### Contacts

- `create_bulk_contact_export(params)` - Create a bulk Contact export with the input parameters defined above
- `list_contact_exports` - List the created Contact exports from Eloqua

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
