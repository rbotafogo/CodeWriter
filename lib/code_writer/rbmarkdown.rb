# coding: utf-8

##########################################################################################
# Copyright © 2013 Rodrigo Botafogo. All Rights Reserved. Permission to use, copy, modify, 
# and distribute this software and its documentation, without fee and without a signed 
# licensing agreement, is hereby granted, provided that the above copyright notice, this 
# paragraph and the following two paragraphs appear in all copies, modifications, and 
# distributions.
#
# IN NO EVENT SHALL RODRIGO BOTAFOGO BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, 
# INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING OUT OF THE USE OF 
# THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF RODRIGO BOTAFOGO HAS BEEN ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.
#
# RODRIGO BOTAFOGO SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE 
# SOFTWARE AND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED HEREUNDER IS PROVIDED "AS IS". 
# RODRIGO BOTAFOGO HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, 
# OR MODIFICATIONS.
##########################################################################################

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

module Markdown
  
  ###########################################################################################
  #
  ###########################################################################################
  
  #------------------------------------------------------------------------------------------
  #
  #------------------------------------------------------------------------------------------
  
  def set_output(output = StIO.new)
    $output = output
  end

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
    print "#{text.align_left}\n\n"
  end
  
  #------------------------------------------------------------------------------------------
  #
  #------------------------------------------------------------------------------------------
    
  def code(script)

    # Let's capture the output of Renjin script in our own string.
    $output.set_std_out(String.new)

    puts script.align_left
    puts
    
    begin
      # eval(script, TOPLEVEL_BINDING)
      eval(script, $binding)
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end

    $output.set_default_std_out
    puts $output.alternate_out.align_left.indent(4)
    
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
      # eval(script, TOPLEVEL_BINDING)
      eval(script, $binding)
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
    end
    
    $output.set_default_std_out
    puts
    puts $output.alternate_out.align_left.indent(4)
    puts
    
  end
  
  #------------------------------------------------------------------------------------------
  #
  #------------------------------------------------------------------------------------------
  
  def comment_code(text)
    puts text.align_left.indent(4)
    puts
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
    puts
  end
  
  #------------------------------------------------------------------------------------------
  #
  #------------------------------------------------------------------------------------------

  def italic(text)
    print "*#{text}*"
  end
  #------------------------------------------------------------------------------------------
  #
  #------------------------------------------------------------------------------------------


  $output = StIO.new
  $binding = binding()
  
end


