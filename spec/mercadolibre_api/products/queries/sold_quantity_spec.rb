require './lib/mercadolibre_api/products/queries/sold_quantity'

RSpec.describe MercadolibreApi::Products::Queries::SoldQuantity do
  let(:product_url) do
    'https://articulo.mercadolibre.com.uy/MLU-445694345-venda-kinesiologica-cinta-terapeutica-tape-deportiva-5mx5cm-_JM'
  end
  let(:br_product_url) do
    'https://produto.mercadolivre.com.br/MLB-915355887-samsung-galaxy-j5-prime-32gb-leitor-digital-flash-4g-2-chip-_JM'
  end

  describe '#run!' do
    it 'returns the sold quantity visiting the website' do
      expect(described_class.run!(product_url: product_url) > 1224).to eq true
    end

    it 'returns the sold quantity visiting the brazilian website' do
      expect(described_class.run!(product_url: br_product_url) > 946).to eq true
    end
  end
end
