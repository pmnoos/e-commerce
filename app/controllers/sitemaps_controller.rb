class SitemapsController < ApplicationController
  layout false

  def index
    @products = Spree::Product.available.order(updated_at: :desc)
    @taxons = Spree::Taxon.where.not(permalink: [ nil, "" ]).order(updated_at: :desc)

    expires_in 1.hour, public: true
  end
end
