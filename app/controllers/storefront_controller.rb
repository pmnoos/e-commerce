class StorefrontController < ApplicationController
  layout "application"

  def index
    @products = Spree::Product.where(slug: [ "my-diary-app", "autobiography-app", "term-deposit-tracker" ]).order(:name)
  end
end
