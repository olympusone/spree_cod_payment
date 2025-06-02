module Spree
  module PaymentMethodDecorator
    def cod_payment?
      method_type == 'cod_payment'
    end

    def cod_payment_available?(order)
      order.shipping_method&.cod?
    end
  end
end

Spree::PaymentMethod.prepend Spree::PaymentMethodDecorator
