module Spree
  module Adjustable
    module Adjuster
      class CodFee
        def initialize(adjustable)
          @adjustable = adjustable
        end

        def apply
          return unless @adjustable.is_a?(Spree::Order)

          cod_payment = @adjustable.payments.valid.detect { |p| p.payment_method.is_a?(Spree::PaymentMethod::CodPayment) }
          return unless cod_payment

          cod_fee = cod_payment.payment_method.preferred_cod_fee.to_d
          return if cod_fee.zero?

          adjustment = @adjustable.adjustments.find_or_initialize_by(
            order: @adjustable,
            source_id: cod_payment.source.id,
            source_type: cod_payment.source.class.name
          )

          adjustment.amount = cod_fee
          adjustment.label = Spree.t(:cod_fee)
          adjustment.state = 'closed'
          adjustment.eligible = true
          adjustment.included = false

          adjustment.save!

          @adjustable.update_totals
          @adjustable.persist_totals
        end

        def cancel
          return unless @adjustable.is_a?(Spree::Order)

          cod_payment = @adjustable.payments.valid.detect { |p| p.payment_method.is_a?(Spree::PaymentMethod::CodPayment) }
          return unless cod_payment

          adjustment = @adjustable.adjustments.find_by(
            order: @adjustable,
            source_id: cod_payment.source.id,
            source_type: cod_payment.source.class.name
          )

          return unless adjustment

          adjustment.destroy!

          @adjustable.update_totals
          @adjustable.persist_totals
        end
      end
    end
  end
end
