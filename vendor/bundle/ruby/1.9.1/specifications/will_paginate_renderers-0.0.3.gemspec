# -*- encoding: utf-8 -*-
# stub: will_paginate_renderers 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "will_paginate_renderers"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Robert Speicher"]
  s.date = "2011-08-09"
  s.description = "A collection of renderers for use with will_paginate."
  s.email = ["rspeicher@gmail.com"]
  s.homepage = "http://rubygems.org/gems/will_paginate_renderers"
  s.rubyforge_project = "will_paginate_renderers"
  s.rubygems_version = "2.2.2"
  s.summary = "A collection of renderers for use with will_paginate"

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<will_paginate>, ["~> 3.0"])
      s.add_development_dependency(%q<mocha>, ["~> 0.9"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<will_paginate>, ["~> 3.0"])
      s.add_dependency(%q<mocha>, ["~> 0.9"])
      s.add_dependency(%q<rspec>, ["~> 2.6"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<will_paginate>, ["~> 3.0"])
    s.add_dependency(%q<mocha>, ["~> 0.9"])
    s.add_dependency(%q<rspec>, ["~> 2.6"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end
