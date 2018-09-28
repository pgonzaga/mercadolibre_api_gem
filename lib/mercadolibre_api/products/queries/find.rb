require 'active_interaction'
require 'net/http'
require './lib/mercadolibre_api/products/entities/product'
require './lib/mercadolibre_api/products/descriptions/queries/find'
require './lib/mercadolibre_api/products/queries/sold_quantity'

module MercadolibreApi
  module Products
    module Queries
      class Find < ActiveInteraction::Base
        string :product_id

        def execute
          response = Net::HTTP.get_response(product_uri)
          response_body = JSON.parse(response.body, symbolize_names: true)
          sold_quantity = MercadolibreApi::Products::Queries::SoldQuantity.run!(product_url: response_body[:permalink])
          description = MercadolibreApi::Products::Descriptions::Queries::Find.run!(
            product_id: product_id, description_id: response_body[:descriptions].dig(0, :id)
          )

          response_body[:description] = description
          response_body[:confirmed_sold_quantity] = sold_quantity
          MercadolibreApi::Products::Entities::Product.represent(response_body).as_json
        end

        private

        def product_uri
          URI("https://api.mercadolibre.com/items/#{product_id}")
        end
      end
    end
  end
end
