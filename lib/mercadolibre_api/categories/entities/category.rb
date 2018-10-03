require 'grape-entity'

module MercadolibreApi
  module Categories
    module Entities
      class Category < Grape::Entity
        expose :id
        expose :name
        expose :path_from_root
        expose :children_categories
      end
    end
  end
end
