require_relative "test_helper"

class ParserTests < Minitest::Test
  def setup
    @lexer = MiniCalc::Lexer.new("1 / 2 * 3")
    @parser = MiniCalc::Parser.new(@lexer)
  end

  def test_parse_expression
    ast = @parser.parse
    assert_instance_of(MiniCalc::AST::BinOpNode, ast)
    assert_equal(:MULTIPLY, ast.operator)

    assert_instance_of(MiniCalc::AST::NumberNode, ast.right)
    assert_equal(3, ast.right.value)

    left_node = ast.left
    assert_instance_of(MiniCalc::AST::BinOpNode, left_node)
    assert_equal(:DIVIDE, left_node.operator)

    assert_instance_of(MiniCalc::AST::NumberNode, left_node.left)
    assert_equal(1, left_node.left.value)
    assert_instance_of(MiniCalc::AST::NumberNode, left_node.right)
    assert_equal(2, left_node.right.value)
  end

  def test_precedence
    lexer = MiniCalc::Lexer.new("2 + 3 * 5")
    parser = MiniCalc::Parser.new(lexer)
    ast = parser.parse

    assert_instance_of MiniCalc::AST::BinOpNode, ast
    assert_equal :PLUS, ast.operator

    assert_instance_of MiniCalc::AST::NumberNode, ast.left
    assert_equal 2, ast.left.value

    right_node = ast.right
    assert_instance_of MiniCalc::AST::BinOpNode, right_node
    assert_equal :MULTIPLY, right_node.operator
    assert_equal 3, right_node.left.value
    assert_equal 5, right_node.right.value
  end

  def test_parentheses_override_precedence
    lexer = MiniCalc::Lexer.new("(2 + 3) * 5")
    parser = MiniCalc::Parser.new(lexer)
    ast = parser.parse

    assert_instance_of MiniCalc::AST::BinOpNode, ast
    assert_equal :MULTIPLY, ast.operator

    assert_instance_of MiniCalc::AST::NumberNode, ast.right
    assert_equal 5, ast.right.value

    left_node = ast.left
    assert_instance_of MiniCalc::AST::BinOpNode, left_node
    assert_equal :PLUS, left_node.operator
    assert_equal 2, left_node.left.value
    assert_equal 3, left_node.right.value
  end
end