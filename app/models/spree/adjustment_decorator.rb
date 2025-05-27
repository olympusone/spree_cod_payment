module Spree
  module AdjustmentDecorator
    def self.prepended(base)
      base.scope :cod_fee, -> { where(source_type: 'Spree::CodPayment') }
    end

    def cod_fee?
      source_type == 'Spree::CodPayment'
    end
  end
end

Spree::Adjustment.prepend Spree::AdjustmentDecorator
