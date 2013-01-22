# acts_as_filterable

acts_as_filterable is an Rails plugin for ActiveRecord to avoid repeating the same text filtering logic that was re-implemented all over the place in a legacy domain model.


## Background

You might ask why we just didn't convert the column value. That _would_ be the right way to go but with tens of millions of rows and numerous legacy apps that expect the data to be a character string; the alternative seemed much more appealing for the time being :). So putting this in place would avoid the garbage data coming in moving forward and assure that the logic is implemented in a sane (and re-usable) way.


## Current default filters

  * digits: leaves only numeric values
  * uppercase: uppercase all alpha characters
  * lowercase: lowercase all alpha characters
  * whitespace: strips and non-essential whitespace out of a string (leaving only single whitespace characters).


## Custom filters.

To create custom filters, create a Rails initializer like `config/initializers/acts_as_filtered.rb` with a configuration block like so. The return value will be used for the new filtered value. Previous version of acts_as_filtered only allowed string mutation, so this is a big win.

```ruby
ActsAsFilterable.configure do |config|

  config.add_filter :default_price do |value|
    value || 0.0
  end

  config.add_filter :integer_cast do |value|
    value.try(:to_i)
  end

end
```

## Versions

  * 0.5.1 - Better Railtie init process and 3.0/3.1 method generation.
    * Default string filters will cast to a string if needed.
    * Added filter stack test for reads and writes. Only 3.2 compatabile and 1.9 compatabile
  * 0.5.0 - Added custom filters and complete overhaul of code.
    * **WARNING!** Interface change, switch from `filter_for_digits :attrib` to `acts_as_filterable :digits, :attrib`.
    * Now uses a Railtie for load hooks. Only patch ActiveRecord when present.
    * Added a dummy Rails application to test against.
    * There is now only one `acts_as_filterable` class method added to ActiveRecord::Base! This also keeps non participating models from getting callbacks that they are not concerned with.
    * Filters are applied to values coming right out of the database too!
  * 0.4.0 - Project refactor and modernization of gem setup.
    

## Testing

The acts_as_filterable gem is fully tested from Rails 3.0 to 3.2. We run our tests in both Ruby 1.8 and 1.9. If you detect a problem, open up a github issue or fork the repo and help out. After you fork or clone the repository, the following commands will get you up and running on the test suite. 

```shell
$ bundle install
$ bundle exec rake appraisal:setup
$ bundle exec rake appraisal test
```

We use the [appraisal](https://github.com/thoughtbot/appraisal) gem from Thoughtbot to help us generate the individual gemfiles for each Rails version and to run the tests locally against each generated Gemfile. The `rake appraisal test` command actually runs our test suite against all Rails versions in our `Appraisal` file. If you want to run the tests for a specific Rails version, use `rake -T` for a list. For example, the following command will run the tests for Rails 3.2 only.

```shell
$ bundle exec rake appraisal:rails32 test
```


## Copyright

Copyright (c) 2010 Rob Ares. See LICENSE for details.
