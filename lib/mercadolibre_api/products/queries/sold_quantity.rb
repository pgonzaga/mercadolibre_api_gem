require 'active_interaction'
require 'net/http'
require 'oga'
require './lib/mercadolibre_api/configurations/vcr'

module MercadolibreApi
  module Products
    module Queries
      class SoldQuantity < ActiveInteraction::Base
        string :product_url

        def execute
          VCR.use_cassette("get-product-html-#{product_uri.path}") do
            response = Net::HTTP.get(product_uri).force_encoding('UTF-8')
            document = Oga.parse_html(response)
            document.at_css('.item-conditions').text.scan(/\d+/).join.to_i
          end
        end

        private

        def product_uri
          @product_uri ||= URI(product_url)
        end
      end
    end
  end
end
