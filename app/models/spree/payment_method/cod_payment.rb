module Spree
    class PaymentMethod::CodPayment < ::Spree::PaymentMethod
      def payment_profiles_supported?
        false # we do not want to show the confirm step
      end
      
      def actions
        %w{capture void}
      end
  
      # Indicates whether its possible to capture the payment
      def can_capture?(payment)
        return false if payment.completed?
        
        payment.order.shipments.all?{|shipment|shipment.state == 'shipped'} \
          && ['checkout', 'pending'].include?(payment.state)
      end
  
      # Indicates whether its possible to void the payment.
      def can_void?(payment)
        payment.state != 'void'
      end
  
      def capture(*args)
        ActiveMerchant::Billing::Response.new(true, "", {}, {})
      end
  
      def cancel(response); end
  
      def void(*args)
        ActiveMerchant::Billing::Response.new(true, "", {}, {})
      end
  
      def source_required?
        false
      end

      def payment_source_class
        nil
      end
  
      def method_type
        'cod_payment'
      end

      def cod_payment?
        true
      end
    end
end