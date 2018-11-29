
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "karel/version"

Gem::Specification.new do |spec|
  spec.name          = "karel-interpreter"
  spec.version       = Karel::Interpreter::VERSION
  spec.authors       = ["Tom Collier"]
  spec.email         = ["collier@apartmentlist.com"]

  spec.summary       = %q{A ruby-based Karel interpreter}
  spec.homepage      = "https://www.github.com/apartmentlist/karel-interpreter"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = ["karel"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "json", "~> 2.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
