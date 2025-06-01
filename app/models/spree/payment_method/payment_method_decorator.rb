module Spree
  module PaymentMethodDecorator
    def available_for_order?(order)
      return cod_payment? && super if order.shipping_method&.cod?

      !cod_payment? && super
    end

    def cod_payment?
      method_type == 'cod_payment'
    end
  end
end

Spree::PaymentMethod.prepend Spree::PaymentMethodDecorator
