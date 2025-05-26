module Spree::OrderDecorator
    def self.prepended(base)
        base.has_many :payment_adjustments, through: :payments, source: :adjustments
    end

    def cod_payment?
        return false unless ship_address.country_iso == 'GR'
        
        payments.where.not(state: ['failed', 'void'])
                .map { |m| m.payment_method.type }
                .include?("Spree::PaymentMethod::CodPayment")
    end
end

::Spree::Order.prepend(Spree::OrderDecorator)
