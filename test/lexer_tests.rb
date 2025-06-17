require_relative "test_helper"

class LexerTests < Minitest::Test
  def test_tokenize_simple_expression
    input = "10 + (5 * 2) / 3 - 1"
    lexer = MiniCalc::Lexer.new(input)

    expected_tokens = [
      MiniCalc::Lexer::Token.new(:NUMBER, 10),
      MiniCalc::Lexer::Token.new(:PLUS, "+"),
      MiniCalc::Lexer::Token.new(:LPAREN, "("),
      MiniCalc::Lexer::Token.new(:NUMBER, 5),
      MiniCalc::Lexer::Token.new(:MULTIPLY, "*"),
      MiniCalc::Lexer::Token.new(:NUMBER, 2),
      MiniCalc::Lexer::Token.new(:RPAREN, ")"),
      MiniCalc::Lexer::Token.new(:DIVIDE, "/"),
      MiniCalc::Lexer::Token.new(:NUMBER, 3),
      MiniCalc::Lexer::Token.new(:MINUS, "-"),
      MiniCalc::Lexer::Token.new(:NUMBER, 1),
      MiniCalc::Lexer::Token.new(:EOF, nil)
    ]

    expected_tokens.each do |expected_token|
      assert_equal expected_token, lexer.next_token
    end
  end
end
