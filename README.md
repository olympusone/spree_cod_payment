# SpreeCodPayment

This is a Cash On Delivery Payment extension for [Spree Commerce](https://spreecommerce.org), an open source e-commerce platform built with Ruby on Rails. Adds Cash on Delivery (COD) payment method to Spree stores.

[![Gem Version](https://badge.fury.io/rb/spree_cod_payment.svg)](https://badge.fury.io/rb/spree_cod_payment)

## Installation

1. Add this extension to your Gemfile with this line:

    ```ruby
    bundle add spree_cod_payment
    ```

2. Install the migrations:

    ```sh
    bundle exec rake railties:install:migrations FROM=spree_cod_payment
    ```

3. Run the migrations:

    ```sh
    bundle exec rails db:migrate
    ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Developing

1. Create a dummy app

    ```bash
    bundle update
    bundle exec rake test_app
    ```

2. Add your new code
3. Run tests

    ```bash
    bundle exec rspec
    ```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_cod_payment/factories'
```

## Releasing a new version

```shell
bundle exec gem bump -p -t
bundle exec gem release
```

For more options please see [gem-release README](https://github.com/svenfuchs/gem-release)

## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2025 OlympusOne, released under the New BSD License
