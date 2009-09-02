# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_filterable}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rob Ares"]
  s.date = %q{2009-09-01}
  s.email = %q{rob.ares@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "acts_as_filterable.gemspec",
     "init.rb",
     "lib/acts_as_filterable.rb",
     "lib/acts_as_filterable/base.rb",
     "rails/init.rb",
     "test/acts_as_filterable_integration_test.rb",
     "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/rares/acts_as_filterable}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{TODO}
  s.test_files = [
    "test/acts_as_filterable_integration_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 1.15.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 1.15.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 1.15.0"])
  end
end
