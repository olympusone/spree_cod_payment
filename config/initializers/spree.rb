Rails.application.config.after_initialize do
  Spree.payment_methods << Spree::PaymentMethod::CodPayment

  Spree.admin.partials.shipping_method_form << 'spree/admin/shipping_methods/cod_form'

  Spree::PermittedAttributes.shipping_method_attributes << :cod
end
