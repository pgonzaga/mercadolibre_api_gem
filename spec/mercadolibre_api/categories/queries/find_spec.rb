RSpec.describe MercadolibreApi::Categories::Queries::Find do
  describe '#run!' do
    it 'returns the category data' do
      VCR.use_cassette('get_category_details') do
        result = described_class.run!(category_id: 'MLU185195')

        expect(result[:id]).to eq 'MLU185195'
        expect(result[:name]).to eq 'Vendas Terapéuticas'
        expect(result[:path_from_root].dig(0, :id)).to eq 'MLU1246'
        expect(result[:children_categories].class).to eq Array
      end
    end
  end
end
