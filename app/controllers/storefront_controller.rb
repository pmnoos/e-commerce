class StorefrontController < ApplicationController
  layout "storefront"

  def index
    @products = Spree::Product.where(slug: [ "my-diary-app", "autobiography-app", "term-deposit-tracker", "grocery-expense-tracker" ]).order(:name)
  end

  def admin_login
    sign_out(:spree_user) if spree_current_user && !spree_current_user.has_spree_role?("admin")

    redirect_to spree.admin_login_path
  end
end
