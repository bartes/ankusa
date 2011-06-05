$:.push File.expand_path("../lib", __FILE__)
require "ankusa/version"
require "rake"
require "date"

Gem::Specification.new do |s|
  s.name = "ankusa"
  s.version = Ankusa::VERSION
  s.authors = ["Brian Muller"]
  s.date = Date.today.to_s
  s.description = "Text classifier with HBase,Cassandra or Redis storage"
  s.summary = "Text classifier in Ruby that"
  s.email = "bartosz.knapik@llp.pl"
  s.files = FileList["lib/**/*", "[A-Z]*", "Rakefile", "docs/**/*"]
  s.homepage = "https://github.com/bartes/ankusa"
  s.require_paths = ["lib"]
  s.add_dependency('fast-stemmer', '>= 1.0.0')
  s.requirements << "Either hbaserb >= 0.0.3 or cassandra >= 0.7 or redis"
  s.rubyforge_project = "ankusa"
end
