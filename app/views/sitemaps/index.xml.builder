xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc root_url
    xml.lastmod Time.current.to_date.iso8601
    xml.changefreq "daily"
    xml.priority "1.0"
  end

  @products.each do |product|
    xml.url do
      xml.loc product_url(product)
      xml.lastmod product.updated_at&.to_date&.iso8601
      xml.changefreq "weekly"
      xml.priority "0.8"
    end
  end

  @taxons.each do |taxon|
    xml.url do
      xml.loc nested_taxons_url(taxon.permalink)
      xml.lastmod taxon.updated_at&.to_date&.iso8601
      xml.changefreq "weekly"
      xml.priority "0.7"
    end
  end
end
