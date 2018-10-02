json.product do
  json.partial! 'api_web/partials/basic_product', product: @product

  json.category do
    json.partial! 'api_web/partials/full_category', category: @product.category
  end

  json.related_products @related_products do |related_product|
    json.partial! 'api_web/partials/basic_product', product: related_product
  end
end
