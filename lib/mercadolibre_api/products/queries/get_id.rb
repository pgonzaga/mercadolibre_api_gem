require 'active_interaction'
require './lib/mercadolibre_api/sites/queries/get_code'

module MercadolibreApi
  module Products
    module Queries
      class GetID < ActiveInteraction::Base
        string :product_url

        def execute
          return unless product_code

          "#{site_code}#{product_code}"
        end

        private

        def site_code
          @site_code ||= MercadolibreApi::Sites::Queries::GetCode.run!(product_url: product_url)
        end

        def product_code
          code_matches = URI(product_url).path.match(/#{site_code}-(\d*)-/)
          return unless code_matches

          code_matches[1]
        end
      end
    end
  end
end
