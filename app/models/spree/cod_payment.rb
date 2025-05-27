module Spree
  class CodPayment < Spree.base_class
    has_many :payments, as: :source
  end
end
