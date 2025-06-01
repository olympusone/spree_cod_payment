module SpreeCodPayment
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_cod_payment'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.after_initialize do |app|
      app.config.spree.payment_methods << Spree::PaymentMethod::CodPayment

      app.config.spree_admin.shipping_method_form_partials << 'spree/admin/shipping_methods/cod_form'

      Spree::PermittedAttributes.shipping_method_attributes << :cod
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
