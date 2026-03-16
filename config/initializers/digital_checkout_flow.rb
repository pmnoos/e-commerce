# frozen_string_literal: true

# Digital-only checkout flow: skip the delivery/shipping step.
Rails.application.config.to_prepare do
  Spree::Order.class_eval do
    # Treat all-digital carts as non-shippable so checkout can move from
    # address directly to payment without calculating shipping rates.
    def shipment_required?
      has_lines = line_items.loaded? ? line_items.any? : line_items.exists?
      if has_lines
        all_digital = line_items.all? do |line_item|
          category_name = line_item.variant.product.shipping_category&.name.to_s
          category_name.casecmp("Digital").zero?
        end
        return false if all_digital
      end

      super
    end

    checkout_flow do
      go_to_state :address
      go_to_state :payment, if: ->(order) { order.payment_required? }
      go_to_state :confirm, if: ->(_order) { Spree::Order.checkout_steps.include?("confirm") }
      go_to_state :complete
    end
  end
end
