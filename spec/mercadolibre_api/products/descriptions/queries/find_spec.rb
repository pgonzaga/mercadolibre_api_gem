require './lib/mercadolibre_api/products/descriptions/queries/find'

RSpec.describe MercadolibreApi::Products::Descriptions::Queries::Find do
  describe '#run!' do
    it 'returns the product description' do
      VCR.use_cassette('get_product_description') do
        result = described_class.run!(description_id: 'MLU445694345-1325488491', product_id: 'MLU445694345')
        expect(result).to_not be_nil
      end
    end
  end
end
