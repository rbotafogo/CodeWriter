=begin
class Markdown

  def get_binding
    return binding()
  end
  
end

$mk = Markdown.new
=end

###########################################################################################
# In some cases, there is the need to redirect standard output to a string.  In general
# class StIO will do it without any problem. However, when integrating with some libraries,
# for instace, Renjin, Renjin standard output and Ruby standard output are different, so
# we need to redirect both standard outputs to the same string.  The integrating library
# will have to implement methods set_std_out, set_std_err, set_default_std_out and
# set_default_std_err.
###########################################################################################

class StIO

  attr_reader :alternate_out
  attr_reader :alternate_err
  
  def set_std_out(buffer)
    $stdout = StringIO.new(buffer)
    @alternate_out = buffer
  end

  def set_std_err(buffer)
    $stderr = StringIO.new(buffer)
    @alternate_err = buffer
  end

  def set_default_std_out
    $stdout = STDOUT
  end

  def set_default_std_out
    $stdout = STDOUT
  end

end

###########################################################################################
#
###########################################################################################

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def set_output(output = StIO.new)
  $output = output
end

set_output

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def title(text)
  print "# #{text}\n\n"
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def author(text)
  print "Author: #{text}\n\n"
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def chapter(text)
  print "# #{text}\n\n"
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def section(text)
  print "## #{text}\n\n"
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def subsection(text)
  print "### #{text}\n\n"
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def subsubsection(text)
  print "#### #{text}\n\n"
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def paragraph(text)
  puts text
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def subparagraph(text)
  puts text
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def body(text)
  print "#{text}\n\n"
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def code(script)

  # Let's capture the output of Renjin script in our own string.
  $output.set_std_out(String.new)
  
  puts script
  begin
    eval(script, TOPLEVEL_BINDING)
  rescue Exception => e
    puts e.message
  end

  $output.set_default_std_out
  puts $output.alternate_out.align_left.indent(4)
  puts
  
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def console(script)

  print(script.align_left.prefix("+ ", "> ").indent(4))

  # Let's capture the output of Renjin script in our own string.
  $output.set_std_out(String.new)
  
  begin
    print("\n\n")
    eval(script, TOPLEVEL_BINDING)
  rescue Exception => e
    puts e.message
  end

  $output.set_default_std_out
  puts $output.alternate_out.align_left.indent(4)
  puts
  
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def comment_code(text)
  puts text.align_left.indent(4)
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def ref(title, publication)
  "*#{title}*, #{publication}"
end

#------------------------------------------------------------------------------------------
#
#------------------------------------------------------------------------------------------

def list(text)
  puts text.align_left.prefix("* ", paragraph: true).indent(2)
end
