require_relative 'lib/nftmaker_api/version'

Gem::Specification.new do |gem|
  gem.name          = "nftmaker_api"
  gem.version       = NftmakerApi::VERSION
  gem.authors       = ["lacepool"]
  gem.email         = ["hello@lacepool.com"]

  gem.summary       = %q{Ruby client for the nft-maker.io PRO API}
  gem.description   = %q{Ruby client that supports all of the nft-maker.io PRO API methods.}
  gem.homepage      = "https://github.com/lacepool"
  gem.license       = "MIT"
  gem.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  gem.metadata["homepage_uri"] = gem.homepage
  gem.metadata["source_code_uri"] = "https://github.com/lacepool/nftmaker_api"

  gem.files = Dir["lib/**/*"]
  gem.require_paths = %w[ lib ]
  gem.extra_rdoc_files = ["LICENSE.txt", "README.md"]

  gem.add_dependency "oj", "~> 3.1"
  gem.add_dependency "faraday", ">= 1", "< 2"

  gem.add_development_dependency "rspec", "~> 3.10"
end
