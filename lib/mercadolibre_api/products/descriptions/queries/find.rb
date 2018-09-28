require 'active_interaction'
require 'net/http'

module MercadolibreApi
  module Products
    module Descriptions
      module Queries
        class Find < ActiveInteraction::Base
          string :description_id
          string :product_id

          def execute
            response = Net::HTTP.get_response(description_uri)
            response_body = JSON.parse(response.body, symbolize_names: true)
            response_body.dig(:plain_text)
          end

          private

          def description_uri
            URI("https://api.mercadolibre.com/items/#{product_id}/descriptions/#{description_id}")
          end
        end
      end
    end
  end
end
