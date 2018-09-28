require 'grape-entity'
require './lib/mercadolibre_api/products/entities/picture'

module MercadolibreApi
  module Products
    module Entities
      class Product < Grape::Entity
        expose :id
        expose :title
        expose :price
        expose :currency_id
        expose :confirmed_sold_quantity, as: :sold_quantity, override: true
        expose :description
        expose :status

        expose :seller_id do |product, _options|
          product.dig(:seller, :id) || product[:seller_id]
        end

        expose :pictures, using: MercadolibreApi::Products::Entities::Picture
        expose :geolocation
      end
    end
  end
end
