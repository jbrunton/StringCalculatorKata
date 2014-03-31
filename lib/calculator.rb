class Calculator

  def add(input)
    return 0 if input.empty?
    numbers = prepare_array(input)
    validate_numbers(numbers)
    numbers.inject(:+)
  end
  
  def validate_numbers(numbers)
    negatives = numbers.select{ |k| k < 0 }
    unless negatives.empty?
      raise "Negatives not allowed: #{negatives.join(', ')}"
    end
  end
  
  # def extract_delimeters(input)
  #   if input.start_with?('//')
  #     delimiter_string, number_string  = input.split("\n")
  #     delimiter_pattern = delimiter_string.slice(2..-1)
  #     [create_delimiter_regexp(delimiter_pattern), number_string]
  #   else
  #     [/,|\n/, input]
  #   end
  # end
  # 
  # def create_delimiter_regexp(delimiter_pattern)
  #   if delimiter_pattern.start_with?('[')
  #     delimiters = delimiter_pattern.
  #       slice(1..-2).
  #       split('][').
  #       map{|d| Regexp.escape(d)}
  #     /#{delimiters.join('|')}/
  #   else
  #     delimiter_pattern
  #   end    
  # end
  
  def find_delimiters(input)
    if input.start_with?('//')
      delimiter_string = input.
        split("\n")[0].
        slice(2..-1)
      if delimiter_string.start_with?('[')
        delimiters = delimiter_string.
          slice(1..-2).
          split('][').
          map{|d| Regexp.escape(d)}
        /#{delimiters.join('|')}/
      else
        delimiter_string
      end
    else
      /,|\n/
    end
  end
  
  def prepare_array(input)
    delimiters, numbers_input = find_delimiters(input)
    if input.start_with?('//')
      input = input.split("\n")[1]
    end
    input.split(delimiters).
      map{|s| s.to_i}.
      select{|k| k <= 1000}
  end

end
