require './lib/mercadolibre_api/sellers/queries/get_id'

RSpec.describe MercadolibreApi::Sellers::Queries::GetID do
  it 'returns nil when URL is an invalid one' do
    VCR.use_cassette('get_seller_id_not_found') do
      expect(described_class.run!(product_id: 0, site_code: 'MLU')).to be_nil
    end
  end

  it 'returns the right seller ID when product URL is valid' do
    VCR.use_cassette('get_seller_id') do
      expect(described_class.run!(product_id: 445_694_345, site_code: 'MLU')).to eq(95_592_600)
    end
  end
end
