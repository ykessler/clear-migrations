# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "clear_migrations"
  spec.version       = "0.0.11"
  spec.authors       = ["Yarin Kessler"]
  spec.email         = ["ykessler@appgrinders.com"]
  spec.description   = %q{Clear out old migrations from Rails projects}
  spec.summary       = %q{Clear out old migrations from Rails projects}
  spec.homepage      = "https://github.com/ykessler/clear-migrations"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
