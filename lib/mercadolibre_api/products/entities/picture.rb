require 'grape-entity'

module MercadolibreApi
  module Products
    module Entities
      class Picture < Grape::Entity
        expose :secure_url, as: :url
      end
    end
  end
end
