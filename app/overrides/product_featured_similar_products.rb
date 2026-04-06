# frozen_string_literal: true

module ProductFeaturedSimilarProducts
  def self.prepended(base)
    base.scope :featured, -> { where(featured: true) }
  end

  def similar_products(limit = 4)
    products = taxons.flat_map do |taxon|
      taxon.all_products_except(id).to_a
    end.uniq

    if products.size < limit
      fallback_products = Spree::Product.available.where.not(id: [ id, *products.map(&:id) ]).limit(limit - products.size)
      products.concat(fallback_products)
    end

    products.first(limit)
  end

  Spree::Product.prepend self
end
