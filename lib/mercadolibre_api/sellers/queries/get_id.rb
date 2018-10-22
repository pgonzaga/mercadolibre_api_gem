require 'active_interaction'
require 'net/http'

module MercadolibreApi
  module Sellers
    module Queries
      class GetID < ActiveInteraction::Base
        string :product_id

        def execute
          response = Net::HTTP.get_response(product_uri)
          JSON.parse(response.body, symbolize_names: true).dig(:seller_id)
        end

        private

        def product_uri
          URI("https://api.mercadolibre.com/items/#{product_id}")
        end
      end
    end
  end
end
