module Spree::PaymentMethodDecorator
    def self.prepended(base)
        base.preference :charge, :string
    end

    def charge
        preferences[:charge].to_f
    end
end
  
::Spree::PaymentMethod.prepend(Spree::PaymentMethodDecorator)