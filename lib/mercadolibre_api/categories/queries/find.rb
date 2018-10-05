require 'active_interaction'
require 'net/http'

module MercadolibreApi
  module Categories
    module Queries
      class Find < ActiveInteraction::Base
        string :category_id

        def execute
          response = Net::HTTP.get_response(uri)
          response_body = JSON.parse(response.body, symbolize_names: true)
          MercadolibreApi::Categories::Entities::Category.represent(response_body).as_json
        end

        private

        def uri
          URI("https://api.mercadolibre.com/categories/#{category_id}")
        end
      end
    end
  end
end
