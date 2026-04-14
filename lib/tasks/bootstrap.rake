namespace :app do
  desc "Bootstrap the production storefront without relying on the full Solidus seed chain"
  task bootstrap: :environment do
    require "carmen"

    host = ENV.fetch("APP_HOST", "example.com")
    store_name = ENV.fetch("STORE_NAME", "Digital Apps Store")
    mail_from = ENV.fetch("CONTACT_EMAIL", ENV.fetch("SMTP_USERNAME", "digital.diary85@gmail.com"))
    store_code = ENV.fetch("STORE_CODE", "sample-store")

    store = Spree::Store.where(default: true).first || Spree::Store.first || Spree::Store.new
    store.name = store_name
    store.code = store.code.presence || store_code
    store.url = host
    store.mail_from_address = mail_from
    store.default = true if store.respond_to?(:default=)
    store.save!

    %w[AU NZ US CA GB].each do |iso|
      carmen_country = Carmen::Country.coded(iso)
      next unless carmen_country

      country = Spree::Country.find_or_initialize_by(iso: carmen_country.alpha_2_code)
      country.name = carmen_country.name
      country.iso3 = carmen_country.alpha_3_code
      country.iso_name = carmen_country.name.upcase
      country.numcode = carmen_country.numeric_code
      country.states_required = carmen_country.subregions?
      country.save!

      next unless carmen_country.subregions?

      carmen_country.subregions.each do |subregion|
        next if subregion.code.blank? || subregion.name.blank?

        Spree::State.where(abbr: subregion.code, country: country).first_or_create!(name: subregion.name)
      end
    end

    Spree::ShippingCategory.find_or_create_by!(name: "Default")
    Spree::ShippingCategory.find_or_create_by!(name: "Digital")

    stock_location = Spree::StockLocation.where(name: "default").first_or_initialize
    stock_location.backorderable_default = true
    stock_location.propagate_all_variants = false
    stock_location.save!

    Spree::Role.find_or_create_by!(name: "admin")

    admin_email = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
    admin_password = ENV.fetch("ADMIN_PASSWORD", "test123")
    admin_user = Spree::User.find_or_initialize_by(email: admin_email)

    if admin_user.new_record?
      admin_user.password = admin_password
      admin_user.password_confirmation = admin_password
      admin_user.login = admin_email if admin_user.respond_to?(:login=)
      admin_user.save!
    end

    admin_role = Spree::Role.find_by!(name: "admin")
    admin_user.spree_roles << admin_role unless admin_user.spree_roles.exists?(admin_role.id)
    admin_user.generate_spree_api_key! if admin_user.respond_to?(:generate_spree_api_key!) && admin_user.spree_api_key.blank?

    load Rails.root.join("db/seeds_storefront.rb")

    puts "Storefront bootstrap completed."
  end
end
