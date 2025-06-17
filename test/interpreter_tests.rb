require_relative "test_helper"

class InterpreterTests < Minitest::Test
  def test_interpreter_addition
    interpreter = MiniCalc::Interpreter.new
    result = interpreter.run("2 + 3")
    assert_equal 5, result
  end

  def test_interpreter_subtraction
    interpreter = MiniCalc::Interpreter.new
    result = interpreter.run("5 - 2")
    assert_equal 3, result
  end

  def test_interpreter_multiplication
    interpreter = MiniCalc::Interpreter.new
    result = interpreter.run("4 * 3")
    assert_equal 12, result
  end

  def test_interpreter_division
    interpreter = MiniCalc::Interpreter.new
    result = interpreter.run("10 / 2")
    assert_equal 5, result
  end

  def test_interpreter_combined_operations
    interpreter = MiniCalc::Interpreter.new
    result = interpreter.run("2 + 3 * 4 - 5 / (1 + 1)")
    assert_equal 11.5, result
  end

  def test_interpreter_with_parentheses
    interpreter = MiniCalc::Interpreter.new
    result = interpreter.run("(2 + 3) * (4 - 1)")
    assert_equal 15, result
  end

  def test_interpreter_complex_expression
    interpreter = MiniCalc::Interpreter.new
    result = interpreter.run("((1 + 2) * (3 + 4)) / (5 - 2)")
    assert_equal 7.0, result
  end
end