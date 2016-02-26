require 'rbconfig'

#
# In principle should not be in this file.  The right way of doing this is by executing
# bundler exec, but I don't know how to do this from inside emacs.  So, should comment
# the next line before publishing the GEM.  If not commented, this should be harmless
# anyway.
#

begin
  require 'bundler/setup'
rescue LoadError
end

##########################################################################################

# the platform
@platform = 
  case RUBY_PLATFORM
  when /mswin/ then 'windows'
  when /mingw/ then 'windows'
  when /bccwin/ then 'windows'
  when /cygwin/ then 'windows-cygwin'
  when /java/
    require 'java' #:nodoc:
    if java.lang.System.getProperty("os.name") =~ /[Ww]indows/
      'windows-java'
    else
      'default-java'
    end
  else 'default'
  end

#---------------------------------------------------------------------------------------
# Set the project directories
#---------------------------------------------------------------------------------------

class CodeWriter

  @home_dir = File.expand_path File.dirname(__FILE__)

  class << self
    attr_reader :home_dir
  end

  @project_dir = CodeWriter.home_dir + "/.."
  @doc_dir = CodeWriter.home_dir + "/doc"
  @lib_dir = CodeWriter.home_dir + "/lib"
  @test_dir = CodeWriter.home_dir + "/test"
  
  class << self
    attr_reader :project_dir
    attr_reader :doc_dir
    attr_reader :lib_dir
    attr_reader :test_dir
  end

end

##########################################################################################
# Load necessary jar files
##########################################################################################
