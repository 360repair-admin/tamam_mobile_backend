# frozen_string_literal: true

require_relative "lib/faulty/version"

Gem::Specification.new do |spec|
  spec.name = "faulty"
  spec.version = Faulty::VERSION
  spec.authors = ["360 Repair"]
  spec.email = ["info@360repair.co"]

  spec.summary = "Faulty is a gem for monitoring and logging errors in your Rails applications."
  spec.description = "Faulty is a gem for monitoring and logging errors in your Rails applications."
  spec.homepage = "https://github.com/360repair/faulty"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/360repair/faulty"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    Dir[
      "app/**/*",
      "bin/**/*",
      "config/**/*",
      "lib/**/*",
      "sig/**/*",
      "LICENSE.txt",
      "README.md",
      "Rakefile"
    ].reject { |f| File.directory?(f) }
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
