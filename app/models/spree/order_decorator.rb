module Spree
  module OrderDecorator
    def cod_fee?
      payment_method.is_a?(Spree::PaymentMethod::CodPayment)
    end
  end
end

Spree::Order.prepend Spree::OrderDecorator
