Announcement
============

CodeWriter is a small Gem to help writing about code.  Writing about code is a tedious process.
First the writer writes in a text editor the text and some piece of code, then to verify the code, it
needs to write this code on some IDE, then execute the code and copy and paste the result of the
executed code.  Later, if the author wants to change/add to the code already writen she needs to change
the code in the IDE, execute it, copy it back to the word processing and the copy the returned value.  In
a large text, with many small code excerpt keeping track of the piece of code and the text is tedious
and often in texts about code, the code in the text has error because it was not executed properly.

CodeWriter tries to reduce this problem for Ruby code.  It is based on the concept of Latex in which
the writer marks the text with tags, but in this case, the marking is actually a Ruby function and the
author is actually writing a Ruby script.

Here is an example of a CodeWriter text:

====
# coding: utf-8
# File writer.rb

require 'codewriter'

title("CodeWriter Example")

author("Rodrigo Botafogo")

body(<<-EOT)
This is a short example of CodeWriter
EOT
====

When writer.rb is executed, it will output a Markdown text.