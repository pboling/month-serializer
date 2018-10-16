# NOTE: Have to use __FILE__ until Ruby 1.x support is dropped
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'month/serializer/version'

Gem::Specification.new do |spec|
  spec.name          = 'month-serializer'
  spec.version       = Month::Serializer::VERSION
  spec.authors       = ['Peter Boling']
  spec.email         = ['peter.boling@gmail.com']

  spec.summary       = 'Serialize Month objects to Integer'
  spec.description   = 'Serialize Month objects to Integer'
  spec.homepage      = 'https://github.com/pboling/month-serializer'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'month', '>= 1.4.0'

  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', ['>= 10.0', '<= 13']
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rspec-pending_for', '~> 0.1'
  spec.add_development_dependency 'rspec-block_is_expected', '~> 1.0'
  spec.add_development_dependency 'wwtd'
end
