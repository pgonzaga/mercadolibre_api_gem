require './lib/mercadolibre_api/products/queries/find'

RSpec.describe MercadolibreApi::Products::Queries::Find do
  describe '#run!' do
    it 'returns the product with description' do
      VCR.use_cassette('get_product_details') do
        result = described_class.run!(product_id: 'MLU445694345')
        expect(result[:sold_quantity]).to eq(1224)
        expect(result[:description]).to_not be_nil
        expect(result[:description]).to_not eq('')
        expect(result[:seller_id]).to eq(95_592_600)
        expect(result[:status]).to eq('active')
        expect(result[:pictures].length).to eq(6)
        expect(result[:geolocation]).to be_present
      end
    end
  end
end
