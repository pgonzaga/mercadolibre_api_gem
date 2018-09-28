require './lib/mercadolibre_api/products/queries/get_id'

RSpec.describe MercadolibreApi::Products::Queries::GetID do
  let(:product_url) do
    'https://articulo.mercadolibre.com.uy/MLU-446242576-oleo-cristalli-liquidi-x-50-ml-alfaparf-_JM#reco_item_pos=2&reco_backend=l3-l7-v2p-ngrams-unified-model&reco_backend_type=function&reco_client=second_best_navigation_trend_homes&reco_id=2d7a1847-2fb2-404a-9f65-a488ee7eaf55&c_id=/home/second-best-navigation-trends-recommendations/element&c_element_order=3'
  end

  describe '#run!' do
    it 'returns null when the url is an invalid one (no http url)' do
      expect(described_class.run!(product_url: 'test')).to be_nil
    end

    it 'returns null when product url is a valid http url but it does not belongs to a product' do
      expect(described_class.run!(product_url: 'http://www.google.com')).to be_nil
    end

    it 'returns the product id when you pass a valid product url' do
      expect(described_class.run!(product_url: product_url)).to eq('MLU446242576')
    end
  end
end
