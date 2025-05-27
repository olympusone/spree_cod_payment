module Spree
  class PaymentMethod::CodPayment < Spree::PaymentMethod
    preference :cod_fee, :decimal, default: 0

    def method_type
      type.demodulize.underscore
    end

    def default_name
      Spree.t(:cod_payment_method)
    end

    def payment_profiles_supported?
      true
    end

    def source_required?
      true
    end

    def payment_source_class
      Spree::CodPayment
    end

    def auto_capture?
      false
    end

    def actions
      %w[capture void]
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      payment.pending? && payment.order.shipped?
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      !payment.void?
    end

    def capture(*)
      simulated_successful_billing_response
    end

    def cancel(*)
      simulated_successful_billing_response
    end

    def credit(*)
      simulated_successful_billing_response
    end

    def authorize(amount, source, options = {})
      order = source.payment.order

      Spree::Adjustable::Adjuster::CodFee.new(order).apply

      simulated_successful_billing_response
    end

    def void(response_code, source, options = {})
      order = source.payment.order
      Spree::Adjustable::Adjuster::CodFee.new(order).cancel

      simulated_successful_billing_response
    end

    def cod_payment?
      true
    end

    def create_profile(payment)
      # This method is intentionally left blank.
      # The CodPayment does not require a profile creation.
    end

    private

    def simulated_successful_billing_response
      ActiveMerchant::Billing::Response.new(true, '', {}, {})
    end
  end
end
