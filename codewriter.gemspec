# -*- coding: utf-8 -*-
require 'rubygems/platform'
require './version'

Gem::Specification.new do |gem|

  gem.name    = $gem_name
  gem.version = $version
  gem.date    = Date.today.to_s

  gem.summary     = "Simple Gem for helping writing about code"
  gem.description = <<-EOF 
This is a simple Gem to help authors write about code
EOF

  gem.authors  = ['Rodrigo Botafogo']
  gem.email    = 'rodrigo.a.botafogo@gmail.com'
  gem.homepage = 'http://github.com/rbotafogo/CodeWriter/wiki'
  gem.license = 'MIT'

  gem.platform='ruby'

  gem.add_development_dependency('shoulda', "~> 3.5")
  gem.add_development_dependency('simplecov', "~> 0.11")
  gem.add_development_dependency('yard', "~> 0.8")
  gem.add_development_dependency('kramdown', "~> 1.0")
  gem.add_development_dependency( 'rake', '~> 10.3')
  
  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', 'version.rb', 'config.rb', '{lib,test}/**/*.rb', 'test/**/*.csv',
                  'test/**/*.xlsx',
                  '{bin,doc,spec,vendor,target,cran}/**/*', 
                  'README*', 'LICENSE*'] # & `git ls-files -z`.split("\0")

  gem.test_files = Dir['test/*.rb']

end
