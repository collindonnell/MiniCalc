module MiniCalc
  class Interpreter
    def run(input)
      lexer = Lexer.new(input)
      parser = Parser.new(lexer)
      ast = parser.parse
      return visit(ast)
    end
    
    private

    def visit(node)
      method_name = "visit_#{node.class.name.split('::').last}"
      send(method_name, node)
    end

    def visit_NumberNode(node)
      node.value
    end

    def visit_BinOpNode(node)
      left_value = visit(node.left)
      right_value = visit(node.right)

      case node.operator
      when :PLUS
        left_value + right_value
      when :MINUS
        left_value - right_value
      when :MULTIPLY
        left_value * right_value
      when :DIVIDE
        left_value / right_value
      else
        raise "Unknown operator: #{node.operator}"
      end
    end

  end
end
