require 'active_interaction'
require 'net/http'
require './lib/mercadolibre_api/products/entities/product'

module MercadolibreApi
  module Sellers
    module Products
      module Queries
        class MostSold < ActiveInteraction::Base
          integer :seller_id
          string :site_code

          def execute
            results = search_uris.map do |uri|
              response = Net::HTTP.get_response(uri)
              JSON.parse(response.body, symbolize_names: true)[:results]
            end

            results.flatten.map { |r| MercadolibreApi::Products::Entities::Product.represent(r).as_json }
          end

          private

          def search_uris
            response = Net::HTTP.get_response(base_uri)
            response_data = JSON.parse(response.body, symbolize_names: true)

            total_products = response_data.dig(:paging, :total)
            product_limit = response_data.dig(:paging, :limit)
            total_calls = (total_products / product_limit).to_i

            0.upto(total_calls).map { |offset_ratio| base_uri(offset: (product_limit * offset_ratio)) }
          end

          def base_uri(offset: 0)
            return URI("#{sites_api_url}/#{site_code}/search?seller_id=#{seller_id}") unless offset.positive?

            URI("#{sites_api_url}/#{site_code}/search?seller_id=#{seller_id}&offset=#{offset}")
          end

          def sites_api_url
            'https://api.mercadolibre.com/sites'
          end
        end
      end
    end
  end
end
