# -*- encoding: utf-8 -*-
# stub: linkedin 0.4.7 ruby lib

Gem::Specification.new do |s|
  s.name = "linkedin"
  s.version = "0.4.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Matthew Kirk", "Wynn Netherland", "Josh Kalderimis"]
  s.date = "2014-04-15"
  s.description = "Ruby wrapper for the LinkedIn API"
  s.email = ["meteor.kirk@gmail.com", "wynn.netherland@gmail.com", "josh.kalderimis@gmail.com"]
  s.homepage = "http://github.com/hexgnu/linkedin"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "This gem interfaces with the Linkedin XML and JSON APis"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hashie>, ["~> 2.0"])
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_runtime_dependency(%q<oauth>, ["~> 0.4"])
      s.add_development_dependency(%q<rake>, ["~> 10"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<kramdown>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.7"])
      s.add_development_dependency(%q<vcr>, ["~> 2.5"])
      s.add_development_dependency(%q<webmock>, ["~> 1.11"])
    else
      s.add_dependency(%q<hashie>, ["~> 2.0"])
      s.add_dependency(%q<multi_json>, ["~> 1.0"])
      s.add_dependency(%q<oauth>, ["~> 0.4"])
      s.add_dependency(%q<rake>, ["~> 10"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<kramdown>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.13"])
      s.add_dependency(%q<simplecov>, ["~> 0.7"])
      s.add_dependency(%q<vcr>, ["~> 2.5"])
      s.add_dependency(%q<webmock>, ["~> 1.11"])
    end
  else
    s.add_dependency(%q<hashie>, ["~> 2.0"])
    s.add_dependency(%q<multi_json>, ["~> 1.0"])
    s.add_dependency(%q<oauth>, ["~> 0.4"])
    s.add_dependency(%q<rake>, ["~> 10"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<kramdown>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.13"])
    s.add_dependency(%q<simplecov>, ["~> 0.7"])
    s.add_dependency(%q<vcr>, ["~> 2.5"])
    s.add_dependency(%q<webmock>, ["~> 1.11"])
  end
end
