Rails.application.config.after_initialize do
  Rails.application.config.spree.payment_methods << Spree::PaymentMethod::CodPayment

  # Admin partials
  Rails.application.config.spree_admin.shipping_method_form_partials << 'spree/admin/shipping_methods/cod_form'

  Spree::PermittedAttributes.shipping_method_attributes << :cod
end
