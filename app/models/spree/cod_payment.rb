module Spree
  class CodPayment < Spree.base_class
    attr_accessor :imported

    belongs_to :user, optional: true
    has_one :payment, as: :source, dependent: :restrict_with_exception
  end
end
