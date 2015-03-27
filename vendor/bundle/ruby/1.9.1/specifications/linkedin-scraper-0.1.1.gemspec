# -*- encoding: utf-8 -*-
# stub: linkedin-scraper 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "linkedin-scraper"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Yatish Mehta"]
  s.date = "2014-03-25"
  s.description = "Scrapes the linkedin profile when a url is given "
  s.executables = ["linkedin-scraper"]
  s.files = ["bin/linkedin-scraper"]
  s.homepage = "https://github.com/yatishmehta27/linkedin-scraper"
  s.rubygems_version = "2.2.2"
  s.summary = "when a url of  public linkedin profile page is given it scrapes the entire page and converts into a accessible object"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mechanize>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<mechanize>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<mechanize>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
