
v_tag = "v0.1.0"
if ENV.key?("TRAVIS_TAG") and !ENV["TRAVIS_TAG"].empty?
  v_tag = ENV["TRAVIS_TAG"]
elsif ENV.key?("BUILD_TAG")
  v_tag = ENV["TRAVIS_TAG"]
end

Gem::Specification.new do |s|

    s.name        = "yaml-cv"
    s.version     = v_tag[1...]

    s.summary     = "Static CV generator from a YAML file, in HTML or PDF format."
    s.description = "Simple tool, with which you can fully populate your CV in user-friendly YAML and then have it generated in HTML or PDF format."

    s.authors     = ["Greg Mantaos"]
    s.email       = "gmantaos@gmail.com"

    s.homepage    = "https://gmantaos.github.io/yaml-cv/"
    s.metadata    = { "source_code_uri" => "https://github.com/gmantaos/yaml-cv" }
    s.licenses    = ["MIT"]

    s.files       = Dir["README.md", "LICENSE", "Gemfile", "{bin,lib}/**/*"]
    s.executables << "yaml-cv"

    s.add_runtime_dependency "mustache", "~> 1.1.0"
    s.add_runtime_dependency "wkhtmltopdf-binary", "~> 0.9.9"
    s.add_runtime_dependency "filewatcher", "~> 1.1.1"
  end