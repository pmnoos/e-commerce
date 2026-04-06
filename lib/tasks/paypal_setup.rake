namespace :paypal do
  desc "Create or update the Solidus PayPal Commerce Platform payment method from ENV"
  task setup: :environment do
    client_id = ENV["PAYPAL_CLIENT_ID"].to_s.strip
    client_secret = ENV["PAYPAL_CLIENT_SECRET"].to_s.strip

    if client_id.empty? || client_secret.empty?
      puts "Skipping PayPal setup: set PAYPAL_CLIENT_ID and PAYPAL_CLIENT_SECRET."
      next
    end

    sandbox = ActiveModel::Type::Boolean.new.cast(
      ENV.fetch("PAYPAL_SANDBOX", "true")
    )

    payment_method = Spree::PaymentMethod.find_or_initialize_by(
      type: "SolidusPaypalCommercePlatform::PaymentMethod"
    )

    payment_method.name = "PayPal Commerce Platform"
    payment_method.active = true if payment_method.respond_to?(:active=)
    payment_method.available_to_users = true if payment_method.respond_to?(:available_to_users=)
    payment_method.available_to_admin = false if payment_method.respond_to?(:available_to_admin=)
    payment_method.preferred_client_id = client_id
    payment_method.preferred_client_secret = client_secret
    payment_method.preferred_test_mode = sandbox

    if payment_method.save
      default_store = Spree::Store.default
      if default_store && payment_method.respond_to?(:stores) && !payment_method.stores.exists?(default_store.id)
        payment_method.stores << default_store
      end

      mode = sandbox ? "sandbox" : "live"
      puts "PayPal payment method configured (#{mode} mode)."
    else
      puts "PayPal setup failed: #{payment_method.errors.full_messages.join(', ')}"
      abort "PayPal setup failed"
    end
  end
end
