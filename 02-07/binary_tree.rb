require_relative "./tree_operations.rb"

class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinaryTree
  include TreeOperations

  attr_reader :root, :level_order_traversal

  def initialize(arr)
    @root = Node.new(arr.shift)
    arr.each { |n| push_node(n) }
    @level_order_traversal = []
  end

  def push_node(node = @root, value)
    if (value >= node.value)
      if node.right
        push_node(node.right, value)
      else
        node.right = Node.new(value)
      end
    else
      if node.left
        push_node(node.left, value)
      else
        node.left = Node.new(value)
      end
    end
  end
end