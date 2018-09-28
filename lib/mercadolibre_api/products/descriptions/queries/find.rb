require 'active_interaction'
require 'net/http'
require './lib/mercadolibre_api/configurations/vcr'

module MercadolibreApi
  module Products
    module Descriptions
      module Queries
        class Find < ActiveInteraction::Base
          string :description_id
          string :product_id

          def execute
            VCR.use_cassette("get-product-#{product_id}-description-#{description_id}") do
              response = Net::HTTP.get_response(description_uri)
              response_body = JSON.parse(response.body, symbolize_names: true)
              response_body.dig(:plain_text)
            end
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
