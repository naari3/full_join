# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'full_join/version'

Gem::Specification.new do |spec|
  spec.name          = 'full_join'
  spec.version       = FullJoin::VERSION
  spec.authors       = ['naari3']
  spec.email         = ['naari.named@gmail.com']

  spec.summary       = 'provides full join for array'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/naari3/full_join'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that
  #   have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(spec)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter'
  spec.add_development_dependency 'rubocop'
end
