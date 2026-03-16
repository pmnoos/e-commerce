# frozen_string_literal: true

module OrdersHelper
  def order_just_completed?(order)
    flash[:order_completed] && order.present?
  end

  def order_download_items(order)
    order.line_items.filter_map do |line_item|
      product = line_item.variant.product
      category_name = product.shipping_category&.name.to_s
      next unless category_name.casecmp("Digital").zero?

      download_url = product.product_properties.joins(:property)
                           .find_by(spree_properties: { name: "Download URL" })&.value
      next if download_url.blank?

      [ product, download_url ]
    end
  end
end
