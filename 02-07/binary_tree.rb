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

  def recur_add
    inp = String.new
    until inp == STOP
      puts "enter the number to add to the tree or enter \"stop\" to stop"
      inp = STDIN.gets.chomp
      puts "\e[H\e[2J"
      if inp != STOP
        if inp != inp.to_i.to_s
          puts "please enter a valid option \n"
        else
          push_node(inp.to_i)
        end
      end
    end
  end

  def largest(node = @root)
    temp = node
    while temp.right do
      temp = temp.right
    end
    temp
  end

  def smallest(node = @root)
    temp = node
    while temp.left do
      temp = temp.left
    end
    temp
  end

  def search(node = @root, value)
    temp = node
    if temp.nil?
      return false
    end
    if temp.value == value
      return true
    end
    left = search(temp.left, value)
    if left
      return true
    else
      right = search(temp.right, value)
      if right
        return true
      else
        return false
      end
    end
    false
  end
  
  def delete(node = @root, value)
    if node.nil?
      return nil
    end

    if (value < node.value)
      node.left = delete(node.left, value)
    elsif (value > node.value)
      node.right = delete(node.right, value)
    else
      # single child node
      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      end

      # node with both children
      temp = smallest(node.right) # find the in_order successor
      node.value = temp.value # copy in_order successor's value
      node.right = delete(node.right, temp.value) # delete the in_order successor node
    end

    node
  end

  def search_helper
    puts "enter number to search "
    inp_int = (STDIN.gets.chomp).to_i
    if search(inp_int)
      puts "Found"
    else
      puts "Missing"
    end
  end

  def delete_helper
    puts "enter number to delete "
    inp_int = (STDIN.gets.chomp).to_i
    return delete(inp_int)
  end

  def add_elements_helper
    puts "enter numbers to add to the tree (space seperated) \n"
    file_data = STDIN.gets.chomp
    arr = file_data.split(' ').map(&:to_i)
    arr.each { |n| push_node(n) }
    return
  end
end