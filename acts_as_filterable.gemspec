# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acts_as_filterable/version'

Gem::Specification.new do |gem|
  gem.name          = "acts_as_filterable"
  gem.version       = ActsAsFilterable::VERSION
  gem.authors       = ["Rob Ares", "Ken Collins"]
  gem.email         = ["rob.ares@gmail.com", "kcollins@customink.com"]
  gem.description   = %q{Filter attributes and stuff.}
  gem.summary       = %q{Filter attributes and stuff.}
  gem.homepage      = "http://github.com/rares/acts_as_filterable"
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_runtime_dependency      'rails', '>= 3.2.0'
  gem.add_development_dependency  'appraisal'
  gem.add_development_dependency  'rake'
  gem.add_development_dependency  'mime-types', '< 3.0'
  gem.add_development_dependency  'minitest'
  gem.add_development_dependency  'sqlite3'
end
