
Gem::Specification.new do |s|

    s.name        = "yaml-cv"
    s.version     = "0.1.0"

    s.summary     = "Static CV generator from a YAML file, in HTML or PDF format."
    s.description = "Much longer explanation of the example!"

    s.authors     = ["Greg Mantaos"]
    s.email       = "gmantaos@gmail.com"

    s.homepage    = "https://github.com/gmantaos/yaml-cv"
    s.metadata    = { "source_code_uri" => "https://github.com/gmantaos/yaml-cv" }
    s.licenses    = ["MIT"]

    s.files       = Dir["README.md", "LICENSE", "Gemfile", "{bin,lib}/**/*"]
    s.executables << "yaml-cv"

    s.add_runtime_dependency "mustache", "~> 1.1.0"
    s.add_runtime_dependency "wkhtmltopdf-binary", "~> 0.9.9"
  end