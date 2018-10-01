require 'active_interaction'
require 'net/http'
require 'oga'

module MercadolibreApi
  module Products
    module Queries
      class SoldQuantity < ActiveInteraction::Base
        string :product_url

        def execute
          response = Net::HTTP.get(product_uri).force_encoding('UTF-8')
          document = Oga.parse_html(response)
          document.at_css('.item-conditions').text.scan(/\d+/).join.to_i
        end

        private

        def product_uri
          URI(product_url)
        end
      end
    end
  end
end
