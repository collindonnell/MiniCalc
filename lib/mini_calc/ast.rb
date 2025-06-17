module MiniCalc
  class AST
    NumberNode = Struct.new(:value)
    BinOpNode = Struct.new(:left, :operator, :right)
  end
end
