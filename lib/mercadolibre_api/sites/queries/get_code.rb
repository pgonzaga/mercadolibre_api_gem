require 'active_interaction'
require 'uri'

module MercadolibreApi
  module Sites
    module Queries
      class GetCode < ActiveInteraction::Base
        string :product_url

        # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
        def execute
          case URI(product_url).host
          when 'articulo.mercadolibre.com.ar'
            'MLA'
          when 'articulo.mercadolibre.com.bo'
            'MBO'
          when 'produto.mercadolivre.com.br'
            'MLB'
          when 'articulo.mercadolibre.cl'
            'MLC'
          when 'articulo.mercadolibre.com.co'
            'MCO'
          when 'articulo.mercadolibre.co.cr'
            'MCR'
          when 'articulo.mercadolibre.com.do'
            'MRD'
          when 'articulo.mercadolibre.com.ec'
            'MEC'
          when 'articulo.mercadolibre.com.gt'
            'MGT'
          when 'articulo.mercadolibre.com.hn'
            'MHN'
          when 'articulo.mercadolibre.com.mx'
            'MLM'
          when 'articulo.mercadolibre.com.ni'
            'MNI'
          when 'articulo.mercadolibre.com.pa'
            'MPA'
          when 'articulo.mercadolibre.com.py'
            'MPY'
          when 'articulo.mercadolibre.com.pe'
            'MPE'
          when 'articulo.mercadolibre.com.sv'
            'MSV'
          when 'articulo.mercadolibre.com.uy'
            'MLU'
          when 'articulo.mercadolibre.com.ve'
            'MLV'
          end
        end
        # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
      end
    end
  end
end
