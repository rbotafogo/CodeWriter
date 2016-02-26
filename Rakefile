require 'rbconfig'
require 'rake/testtask'

require './version'

$env = `uname -o`.strip

##########################################################################################
# Prepare environment to work inside Cygwin
##########################################################################################

if $env == 'Cygwin'

  #---------------------------------------------------------------------------------------
  # Return the cygpath (windows format) of a path in POSIX format, i.e., /home/...
  #---------------------------------------------------------------------------------------
  
  def set_path(path)
    `cygpath -a -w #{path}`.tr("\n", "")
  end
  
else
  
  #---------------------------------------------------------------------------------------
  # Return the given path.  When not in cygwin then just use the given path
  #---------------------------------------------------------------------------------------
  
  def set_path(path)
    path
  end
  
end
##########################################################################################

name = "#{$gem_name}-#{$version}.gem"

desc 'Makes a Gem'
task :make_gem do
  sh "gem build #{$gem_name}.gemspec"
end

desc 'Install the gem in the standard location'
task :install_gem => [:make_gem] do
  sh "gem install #{$gem_name}-#{$version}-java.gem"
end

desc 'Make documentation'
task :make_doc do
  sh "yard doc lib/*.rb lib/**/*.rb"
end

desc 'Push project to github'
task :push do
  sh "git push origin master"
end

desc 'Push gem to rubygem'
task :push_gem do
  sh "push #{name} -p $http_proxy"
end

desc 'Counts the number of lines of ruby code'
task :count do
  sh "find . -name '*.rb' | xargs wc -l"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/complete.rb']
  t.ruby_opts = ["--server", "-Xinvokedynamic.constants=true", "-J-Xmn512m", 
                 "-J-Xms1024m", "-J-Xmx1024m"]
  t.verbose = true
  t.warning = true
end

