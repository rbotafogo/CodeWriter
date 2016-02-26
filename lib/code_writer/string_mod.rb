
###########################################################################################
#
###########################################################################################

class String

  #----------------------------------------------------------------------------------------
  # Return an indented copy of this string
  # Arguments:
  # * num - How many of the specified indentation to use.
  #         Default for spaces is 2. Default for other is 1.
  #         If set to a negative value, removes that many of the specified indentation character,
  #         tabs, or spaces from the beginning of the string
  # * i_char - Character (or string) to use for indentation
  #----------------------------------------------------------------------------------------

  def indent(num = nil, i_char = ' ')
    _indent(num, i_char)
  end
  
  #----------------------------------------------------------------------------------------
  # Indents this string
  # Arguments:
  # * num - How many of the specified indentation to use.
  #         Default for spaces is 2. Default for other is 1.
  #         If set to a negative value, removes that many of the specified indentation character,
  #         tabs, or spaces from the beginning of the string
  # * i_char - Character (or string) to use for indentation
  #----------------------------------------------------------------------------------------

  def indent!(num = nil, i_char = ' ')
    replace(_indent(num, i_char))
  end
  
  #----------------------------------------------------------------------------------------
  # Split across newlines and return the fewest number of indentation characters found on
  # each line
  #----------------------------------------------------------------------------------------

  def find_least_indentation(options = {:ignore_blank_lines => true, :ignore_empty_lines => true})
    # Cannot ignore empty lines unless we're also ignoring blank lines
    options[:ignore_blank_lines] = options[:ignore_empty_lines] ? true : options[:ignore_blank_lines]
    empty? ? 0 : split("\n", -1).reject{|line|
      if options[:ignore_empty_lines]
        line.strip.empty?
      elsif options[:ignore_blank_lines]
        line.empty?
      else
        false
      end
    }.collect{|substr| substr.match(/^[ \t]*/).to_s.length}.min
  end
  
  #----------------------------------------------------------------------------------------
  # Find the least indentation of all lines within this string and remove that amount (if any)
  # Can pass an optional modifier that changes the indentation amount removed
  #----------------------------------------------------------------------------------------
  
  def reset_indentation(modifier = 0)
    indent(-find_least_indentation + modifier)
  end
  
  #----------------------------------------------------------------------------------------
  # Replaces the current string with one that has had its indentation reset
  # Can pass an optional modifier that changes the indentation amount removed
  #----------------------------------------------------------------------------------------
  
  def reset_indentation!(modifier = 0)
    indent!(-find_least_indentation + modifier)
  end
  
  #----------------------------------------------------------------------------------------
  #
  #----------------------------------------------------------------------------------------

  def align_left
    string = dup
    relevant_lines = string.split(/\r\n|\r|\n/).select { |line| line.size > 0 }
    indentation_levels = relevant_lines.map do |line|
      match = line.match(/^( +)[^ ]+/)
      match ? match[1].size : 0
    end
    indentation_level = indentation_levels.min
    string.gsub! /^#{' ' * indentation_level}/, '' if indentation_level > 0
    string
  end

  #----------------------------------------------------------------------------------------
  #
  #----------------------------------------------------------------------------------------

  def prefix(prefix, prefix_1 = prefix)

    # str_array = split("\n", -1)
    split("\n").map
      .with_index { |line, i| (i == 0)? prefix_1 + line : prefix + line }.join("\n")
    
  end
  
  #----------------------------------------------------------------------------------------
  #
  #----------------------------------------------------------------------------------------

  private
  
  #----------------------------------------------------------------------------------------
  #
  #----------------------------------------------------------------------------------------

  def _indent(num = nil, i_char = ' ')

    # Define number of indentations to use
    number = num
    # Default number to 2 if spaces or 1 if other
    number ||= (i_char == ' ') ? 2 : 1

    str_arr = []
    case
    when number >= 0
      split("\n", -1).collect{|line| (i_char * number) + line}.join("\n")
    else
      i_regexp = Regexp.new("^([ \t]|#{i_char})")
      split("\n", -1).collect do |line|
        ret_str = String.new(line)
        number.abs.times do
          match = ret_str.sub!(i_regexp, '')
          break unless match
        end
        ret_str
      end.join("\n")
      
    end

  end
  
end
