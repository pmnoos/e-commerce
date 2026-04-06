# frozen_string_literal: true

module ProductScreenshotsHelper
  SCREENSHOT_PREFIX_ALIASES = {
    "my-diary-app" => %w[my_diary_app my-diary-app diary diary_app],
    "autobiography-app" => %w[autobiography_app autobiography-app autobiography auto_bio auto-bio],
    "term-deposit-tracker" => %w[term_deposit_tracker term-deposit-tracker term],
    "grocery-expense-tracker" => %w[grocery_expense_tracker grocery-expense-tracker grocery food]
  }.freeze

  def screenshot_assets_for(product_or_slug)
    slug = product_or_slug.respond_to?(:slug) ? product_or_slug.slug : product_or_slug
    screenshot_prefixes_for(slug).flat_map do |prefix|
      discover_screenshot_assets(prefix)
    end.uniq
  end

  def primary_screenshot_asset_for(product_or_slug)
    screenshot_assets_for(product_or_slug).first
  end

  private

  def screenshot_prefixes_for(slug)
    explicit_prefixes = SCREENSHOT_PREFIX_ALIASES.fetch(slug, [])
    derived_prefixes = [
      slug,
      slug.tr("-", "_"),
      slug.delete("-"),
      slug.split("-").first
    ]

    (explicit_prefixes + derived_prefixes).compact.uniq
  end

  def discover_screenshot_assets(prefix)
    return [] if prefix.blank?

    screenshot_directory_entries.filter_map do |filename|
      basename = File.basename(filename, File.extname(filename))
      next unless screenshot_name_matches_prefix?(basename, prefix)

      [ screenshot_sort_key(basename, prefix), "screenshots/#{filename}" ]
    end.sort_by(&:first).map(&:last)
  end

  def screenshot_directory_entries
    screenshots_path = Rails.root.join("app/assets/images/screenshots")
    return [] unless Dir.exist?(screenshots_path)

    Dir.children(screenshots_path).select do |filename|
      File.file?(screenshots_path.join(filename))
    end
  end

  def screenshot_name_matches_prefix?(basename, prefix)
    basename == prefix ||
      basename.start_with?("#{prefix}_") ||
      basename.start_with?("#{prefix}-") ||
      basename.match?(/\A#{Regexp.escape(prefix)}\d+\z/)
  end

  def screenshot_sort_key(basename, prefix)
    trailing_number = basename.delete_prefix(prefix)[/\d+/]
    [ basename == prefix ? 0 : 1, trailing_number ? trailing_number.to_i : 0, basename ]
  end
end
