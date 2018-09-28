require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = './lib/mercadolibre_api/cache'
  c.hook_into :webmock
  c.default_cassette_options = {
    record: :new_episodes,
    re_record_interval: 1.minute
  }
end
