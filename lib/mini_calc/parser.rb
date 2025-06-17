module MiniCalc
  class Parser
    def initialize(lexer)
      @lexer = lexer
      @current_token = @lexer.next_token
    end

    def parse
      # Handle empty input
      return AST::NumberNode.new(0) if @current_token.type == :EOF

      node = parse_expression

      if @current_token.type != :EOF
        raise "Parse Error: Unexpected token after factor: #{@current_token.type}"
      end

      return node
    end

    private

    def eat(token_type)
      if @current_token.type == token_type
        @current_token = @lexer.next_token
      else
        raise "Parse Error: Unexpected token: #{@current_token.type}, expected: #{token_type}"
      end
    end

    def parse_factor
      token = @current_token
      case token.type
      when :NUMBER
        eat(:NUMBER)
        return AST::NumberNode.new(token.value)
      when :LPAREN
        # Call parse_expression to handle the inner expression
        eat(:LPAREN)
        node = parse_expression
        # Expect a closing parenthesis
        eat(:RPAREN)
        return node
      else
        raise "Unexpected token in factor: #{token.type}"
      end
    end

    def parse_term
      node = parse_factor

      while %i(MULTIPLY DIVIDE).include?(@current_token.type)
        operator = @current_token
        eat(operator.type)
        right = parse_factor
        node = AST::BinOpNode.new(left: node, operator: operator.type, right: right)
      end

      return node
    end

    def parse_expression
      node = parse_term

      while %i(PLUS MINUS).include?(@current_token.type)
        operator = @current_token
        eat(operator.type)
        right = parse_term
        node = AST::BinOpNode.new(left: node, operator: operator.type, right: right)
      end

      return node
    end
  end
end
