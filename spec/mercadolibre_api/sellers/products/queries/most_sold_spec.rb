RSpec.describe MercadolibreApi::Sellers::Products::Queries::MostSold do
  describe '#search_uris' do
    it 'returns the right search URIs' do
      VCR.use_cassette('search_seller_without_offsets') do
        most_sold_query = described_class.new(seller_id: 95_592_600, site_code: 'MLU')
        expected_result = [
          URI('https://api.mercadolibre.com/sites/MLU/search?seller_id=95592600'),
          URI('https://api.mercadolibre.com/sites/MLU/search?seller_id=95592600&offset=50'),
          URI('https://api.mercadolibre.com/sites/MLU/search?seller_id=95592600&offset=100'),
          URI('https://api.mercadolibre.com/sites/MLU/search?seller_id=95592600&offset=150')
        ]

        expect(most_sold_query.send(:search_uris)).to eq(expected_result)
      end
    end
  end

  describe '#run!' do
    it 'returns the right product data' do
      VCR.use_cassette('search_seller_with_offsets') do
        result = described_class.run!(seller_id: 95_592_600, site_code: 'MLU')
        expect(result.length).to eq(185)
        expect(result[0][:id]).to eq('MLU445694345')
        expect(result[184][:id]).to eq('MLU445743927')
      end
    end

    it 'returns an empty array' do
      VCR.use_cassette('search_seller_with_invalid_site_code') do
        result = described_class.run!(seller_id: 95_592_600, site_code: 'MLU-1')
        expect(result.length).to eq(0)
      end
    end
  end
end
