# Spree COD Payment

This is a Cash On Delivery Payment extension for [Spree Commerce](https://spreecommerce.org), an open source e-commerce platform built with Ruby on Rails. Adds Cash on Delivery (COD) payment method option during checkout.

[![Gem Version](https://badge.fury.io/rb/spree_cod_payment.svg)](https://badge.fury.io/rb/spree_cod_payment)

## Installation

1. Add this extension to your Gemfile with this line:

    ```bash
    bundle add spree_cod_payment
    ```

2. Run the install generator

    ```bash
    bundle exec rails g spree_cod_payment:install
    ```

3. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Usage

1. Create a Payment Method for Cash on Delivery (e.g. name: "Cash on Delivery") whose `method_type` is `cod_payment`.
2. This gem supplies helpers:
   * `payment_method.cod_payment?`
   * `payment_method.cod_payment_available?(order)` (true when the order’s shipping method supports COD)
3. To show the COD payment method ONLY when eligible (and optionally hide it for store pickup), add a decorator in the host app:

````ruby
module Spree
  module PaymentMethodDecorator
    def available_for_order?(order)
      return false unless super

      # Show COD only when shipping method allows it.
      if cod_payment_available?(order)
        return cod_payment?
      end

      # If integrating with store pickup (from spree_store_pickup):
      if respond_to?(:store_pickup_available?) && store_pickup_available?(order)
        return false if cod_payment?            # Hide COD during pickup
        return !cod_payment?                    # Allow other methods
      end

      # Hide specialized method when its condition is not met.
      return false if cod_payment?

      true
    end
  end

  PaymentMethod.prepend PaymentMethodDecorator
end
````

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

```bash
bundle exec gem bump -p -t
bundle exec gem release
```

For more options please see [gem-release README](https://github.com/svenfuchs/gem-release)

## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2025 OlympusOne, released under the AGPL-3.0 or later.
