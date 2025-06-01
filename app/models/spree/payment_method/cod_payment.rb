module Spree
  class PaymentMethod::CodPayment < Spree::PaymentMethod
    def method_type
      type.demodulize.underscore
    end

    def default_name
      Spree.t(:cod_payment_method)
    end

    def source_required?
      false
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

    private

    def simulated_successful_billing_response
      ActiveMerchant::Billing::Response.new(true, '', {}, {})
    end
  end
end
