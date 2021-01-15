lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mercadolibre_api/version'

Gem::Specification.new do |gem|
  gem.name          = 'mercadolibre_api'
  gem.version       = MercadolibreApi::VERSION
  gem.authors       = ['Pablo Gonzaga']
  gem.email         = ['pgonzaga.uy@gmail.com']

  gem.summary       = 'Mercadolibre API client'
  gem.description   = 'Client to consume all Mercadolibre endpoints'
  gem.homepage      = 'https://github.com/pgonzaga/mercadolibre_api_gem'
  gem.license       = 'MIT'

  gem.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  gem.bindir        = 'exe'
  gem.executables   = gem.files.grep(%r{^exe/}) { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_dependency 'active_interaction', '~> 3.6'
  gem.add_dependency 'grape-entity', '~> 0.7.1'
  gem.add_dependency 'oga', '~> 2.15'

  gem.add_development_dependency 'bundler', '~> 1.16'
  gem.add_development_dependency 'byebug', '~> 10.0'
  gem.add_development_dependency 'rake', '~> 12.3'
  gem.add_development_dependency 'rspec', '~> 3.8'
  gem.add_development_dependency 'rubocop', '~> 1.8'
  gem.add_development_dependency 'vcr', '~> 4.0'
  gem.add_development_dependency 'webmock', '~> 3.4'
end
