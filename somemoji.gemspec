lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "somemoji/version"

Gem::Specification.new do |spec|
  spec.name = "somemoji"
  spec.version = Somemoji::VERSION
  spec.authors = ["Ryo Nakamura"]
  spec.email = ["r7kamura@gmail.com"]
  spec.summary = "A grand unified emoji mapper for some emoji providers."
  spec.homepage = "https://github.com/r7kamura/somemoji"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "gemoji", "3.0.0.rc1"
  spec.add_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "gemojione", "3.2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "3.5.0"
  spec.add_development_dependency "twemoji", "3.0.1"
end
