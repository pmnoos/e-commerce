Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Public storefront landing page.
  root to: "storefront#index"
  get "store" => "storefront#index"
  get "privacy" => "pages#privacy", as: :privacy
  get "terms" => "pages#terms", as: :terms
  get "refunds" => "pages#refunds", as: :refunds
  get "contact" => "pages#contact", as: :contact
  get "admin/switch-login" => "storefront#admin_login", as: :switch_admin_login
  get "sitemap.xml" => "sitemaps#index", defaults: { format: :xml }

  devise_for(:user, {
    class_name: "Spree::User",
    singular: :spree_user,
    controllers: {
      sessions: "user_sessions",
      registrations: "user_registrations",
      passwords: "user_passwords",
      confirmations: "user_confirmations"
    },
    skip: [ :unlocks, :omniauth_callbacks ],
    path_names: { sign_out: "logout" }
  })

  resources :users, only: [ :edit, :update ]

  devise_scope :spree_user do
    get "/login", to: "user_sessions#new", as: :login
    post "/login", to: "user_sessions#create", as: :create_new_session
    match "/logout", to: "user_sessions#destroy", as: :logout, via: Devise.sign_out_via
    get "/signup", to: "user_registrations#new", as: :signup
    post "/signup", to: "user_registrations#create", as: :registration
    get "/password/recover", to: "user_passwords#new", as: :recover_password
    post "/password/recover", to: "user_passwords#create", as: :reset_password
    get "/password/change", to: "user_passwords#edit", as: :edit_password
    put "/password/change", to: "user_passwords#update", as: :update_password
    get "/confirm", to: "user_confirmations#show", as: :confirmation if Spree::Auth::Config[:confirmable]
  end

  resource :account, controller: "users"

  # Storefront purchase flow routes.
  resources :products, only: [ :index, :show ]
  resources :autocomplete_results, only: :index
  resources :cart_line_items, only: :create
  get "/locale/set", to: "locale#set"
  post "/locale/set", to: "locale#set", as: :select_locale

  resource :cart, only: [ :show, :update ] do
    put :empty
  end

  resource :checkout_session, only: :new
  resource :checkout_guest_session, only: :create
  patch "/checkout/update/:state", to: "checkouts#update", as: :update_checkout
  get "/checkout/update/:state", to: redirect("/checkout/%{state}")
  get "/checkout/:state", to: "checkouts#edit", as: :checkout_state
  get "/checkout", to: "checkouts#edit", as: :checkout

  get "/orders/:id/token/:token", to: "orders#show", as: :token_order

  resources :orders, only: :show do
    resources :coupon_codes, only: :create
  end

  get "/t/*id", to: "taxons#show", as: :nested_taxons
  get "/unauthorized", to: "home#unauthorized", as: :unauthorized
  get "/cart_link", to: "store#cart_link", as: :cart_link

  if defined?(SolidusPaypalCommercePlatform::Engine)
    mount SolidusPaypalCommercePlatform::Engine, at: "/solidus_paypal_commerce_platform"
  end
  # Starter storefront routes are disabled for now to avoid route/name collisions.
  # scope(path: "/") { draw :storefront }
  # This line mounts Solidus's routes at the root of your application.
  #
  # Unless you manually picked only a subset of Solidus components, this will mount routes for:
  #   - solidus_backend
  #   - solidus_api
  # This means, any requests to URLs such as /admin/products, will go to Spree::Admin::ProductsController.
  #
  # If you are using the Starter Frontend as your frontend, be aware that all the storefront routes are defined
  # separately in this file and are not part of the Solidus::Core::Engine engine.
  #
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  # We ask that you don't use the :as option here, as Solidus relies on it being the default of "spree"
  mount Spree::Core::Engine, at: "/"
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
