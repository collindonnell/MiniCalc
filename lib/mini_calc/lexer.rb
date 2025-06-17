module MiniCalc
  class Lexer
    Token = Struct.new(:type, :value)

    def initialize(input)
      @input = input
      @position = 0
    end

    def next_token
      skip_whitespace

      return Token.new(:EOF, nil) if end_of_input?

      char = current_char

      case char
      when '+'
        advance
        return Token.new(:PLUS, '+')
      when '-'
        advance
        return Token.new(:MINUS, '-')
      when '*'
        advance
        return Token.new(:MULTIPLY, '*')
      when '/'
        advance
        return Token.new(:DIVIDE, '/')
      when '('
        advance
        return Token.new(:LPAREN, '(')
      when ')'
        advance
        return Token.new(:RPAREN, ')')
      when /\d/
        return Token.new(:NUMBER, read_number)
      else
        raise "Unexpected character: #{char}"
      end
    end

    private

    def current_char = @input[@position]

    def advance
      @position += 1
    end

    def skip_whitespace
      advance while !end_of_input? && current_char =~ /\s/
    end

    def read_number
      start = @position
      advance while !end_of_input? && current_char =~ /\d/
      @input[start...@position].to_f
    end

    def end_of_input?
      @position >= @input.length
    end
  end
end
