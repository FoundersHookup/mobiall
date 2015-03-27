# -*- encoding: utf-8 -*-
# stub: less 2.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "less"
  s.version = "2.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Charles Lowell"]
  s.date = "2012-09-04"
  s.description = "Invoke the Less CSS compiler from Ruby"
  s.email = ["cowboyd@thefrontside.net"]
  s.executables = ["lessc"]
  s.files = ["bin/lessc"]
  s.homepage = "http://lesscss.org"
  s.rubyforge_project = "less"
  s.rubygems_version = "2.2.2"
  s.summary = "Leaner CSS, in your browser or Ruby (via less.js)"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<commonjs>, ["~> 0.2.6"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
    else
      s.add_dependency(%q<commonjs>, ["~> 0.2.6"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
    end
  else
    s.add_dependency(%q<commonjs>, ["~> 0.2.6"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
  end
end
