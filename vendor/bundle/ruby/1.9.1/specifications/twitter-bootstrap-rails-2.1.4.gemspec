# -*- encoding: utf-8 -*-
# stub: twitter-bootstrap-rails 2.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "twitter-bootstrap-rails"
  s.version = "2.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Seyhun Akyurek"]
  s.date = "2012-10-15"
  s.description = "twitter-bootstrap-rails project integrates Bootstrap CSS toolkit for Rails 3.1 Asset Pipeline"
  s.email = ["seyhunak@gmail.com"]
  s.homepage = "https://github.com/seyhunak/twitter-bootstrap-rails"
  s.rubyforge_project = "twitter-bootstrap-rails"
  s.rubygems_version = "2.2.2"
  s.summary = "Bootstrap CSS toolkit for Rails 3.1 Asset Pipeline"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.1"])
      s.add_runtime_dependency(%q<actionpack>, [">= 3.1"])
      s.add_runtime_dependency(%q<therubyracer>, [">= 0.10.2"])
      s.add_runtime_dependency(%q<less-rails>, ["~> 2.2.3"])
      s.add_development_dependency(%q<rails>, [">= 3.1"])
    else
      s.add_dependency(%q<railties>, [">= 3.1"])
      s.add_dependency(%q<actionpack>, [">= 3.1"])
      s.add_dependency(%q<therubyracer>, [">= 0.10.2"])
      s.add_dependency(%q<less-rails>, ["~> 2.2.3"])
      s.add_dependency(%q<rails>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.1"])
    s.add_dependency(%q<actionpack>, [">= 3.1"])
    s.add_dependency(%q<therubyracer>, [">= 0.10.2"])
    s.add_dependency(%q<less-rails>, ["~> 2.2.3"])
    s.add_dependency(%q<rails>, [">= 3.1"])
  end
end