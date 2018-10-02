require 'active_interaction'
require 'net/http'

module MercadolibreApi
  module Sellers
    module Queries
      class GetID < ActiveInteraction::Base
        integer :product_id
        string :site_code

        def execute
          response = Net::HTTP.get_response(product_uri)
          JSON.parse(response.body, symbolize_names: true).dig(:seller_id)
        end

        private

        def product_uri
          URI("https://api.mercadolibre.com/items/#{site_code}#{product_id}")
        end
      end
    end
  end
end
