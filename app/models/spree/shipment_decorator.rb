module Spree::ShipmentDecorator
    def determine_state(order)
        return 'ready' if cod_payment? && !shipped?
        
        return 'canceled' if order.canceled?
        return 'pending' unless order.can_ship?
        return 'pending' if inventory_units.any? &:backordered?
        return 'shipped' if shipped?

        return order.paid? || Spree::Config[:auto_capture_on_dispatch] ? 'ready' : 'pending'
    end

    private
    def cod_payment?
        return false unless order.ship_address.country_iso == 'GR'
        
        order.payments.any? do |payment|
            payment.payment_method.type == "Spree::PaymentMethod::CodPayment" && !payment.void?
        end
    end
end

::Spree::Shipment.prepend(Spree::ShipmentDecorator)