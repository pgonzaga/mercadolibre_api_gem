require 'active_interaction'
require 'net/http'

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

            results.flatten!
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
            if offset.positive?
              URI("https://api.mercadolibre.com/sites/#{site_code}/search?seller_id=#{seller_id}&offset=#{offset}")
            else
              URI("https://api.mercadolibre.com/sites/#{site_code}/search?seller_id=#{seller_id}")
            end
          end
        end
      end
    end
  end
end
