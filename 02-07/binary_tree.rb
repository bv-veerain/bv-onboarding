# Build a Binary tree data structure with following operations. Use OOPs concepts in this. Follow coding guidelines
# [x] Add elements into the tree(multiple elements comma separated)
# [x] Print the largest element
# [x] Print the smallest element
# [x] Print In_order, post_order, level order, and pre_order traversal
# [x] Search an element
# [x] Remove an element
# [x] Print all the paths i.e starting from root to the leaf
# [x] Script should run and serve until quit is not given as input
# [x] Write all the elements to a file on quit command 
# [x] Option to start script with a file input and load BST with integers inside that file

require 'io/console'

class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

module Commands
  PRINT_PATHS = 1
  SEARCH = 2
  SMALLEST = 3
  LARGEST = 4
  DELETE = 5
  PRE_ORDER = 6
  POST_ORDER = 7
  IN_ORDER = 8
  LEVEL_ORDER = 9
  ADD_ELEMENTS = 10
  QUIT = "quit"
end

class BinaryTree
  attr_reader :root, :level_order_traversal

  include Commands

  def initialize(root)
    @root = root
    @level_order_traversal = []
  end

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

  def in_order(node = @root)
    if (node == nil)
      return
    end
    in_order(node.left)
    print(node.value, " ")
    in_order(node.right)
  end

  def post_order(node = @root)
    if (node == nil)
      return
    end
    post_order(node.left)
    post_order(node.right)
    print(node.value, " ")
  end

  def pre_order(node = @root)
    if (node == nil)
      return
    end
    print(node.value, " ")
    pre_order(node.left)
    pre_order(node.right)
  end

  def level_order(node = @root)
    if (node == nil)
      puts "Queue is empty"
      return
    end
    que = []
    que << @root
    while (!que.empty?) do
      node = que.shift
      print("#{node.value} ")
      unless node.left.nil?
        que << node.left
      end
      unless node.right.nil?
        que << node.right
      end
    end
  end

  def generate_level_order(node = @root)
    if (node == nil)
      return
    end
    que = []
    que << @root
    while (!que.empty?) do
      node = que.shift
      @level_order_traversal << node.value
      unless node.left.nil?
        que << node.left
      end
      unless node.right.nil?
        que << node.right
      end
    end
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

  def print_array(paths, path_len)
    (0..path_len-1).each { |i| print(paths[i], " ")}
    print("\n")
  end

  def print_paths_recur(node, paths, path_len)
    if node.nil?
      return
    end
    paths[path_len] = node.value
    path_len += 1
    if (node.left.nil? && node.right.nil?)
      print_array(paths, path_len)
    else
      print_paths_recur(node.left, paths, path_len)
      print_paths_recur(node.right, paths, path_len)
    end
  end

  def print_paths(node = @root)
    paths = Array.new(1000)
    print_paths_recur(node, paths, 0)
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

  def input_handler(inp)
    if inp != Commands::QUIT
      case inp.to_i
      when BinaryTree::PRINT_PATHS then puts print_paths, "\n"
      when BinaryTree::SEARCH then puts search_helper, "\n"
      when BinaryTree::SMALLEST then puts smallest.value, "\n"
      when BinaryTree::LARGEST then puts largest.value, "\n"
      when BinaryTree::DELETE then puts delete_helper, "\n"
      when BinaryTree::PRE_ORDER then puts pre_order, "\n"
      when BinaryTree::POST_ORDER then puts post_order, "\n"
      when BinaryTree::IN_ORDER then puts in_order, "\n"
      when BinaryTree::LEVEL_ORDER then puts level_order, "\n"
      when BinaryTree::ADD_ELEMENTS then puts add_elements_helper, "\n"
      else puts "enter a valid choice "
      end
    end
  end
end

unless ARGV.empty?
  file = File.open(ARGV[0], "r+")
  file_data = file.read
  file.close
  arr = file_data.split(' ').map(&:to_i)
else
  puts "enter the array space seperated to build binary tree \n"
  file_data = STDIN.gets.chomp
  arr = file_data.split(' ').map(&:to_i)
end

binary_tree = BinaryTree.new(arr)

inp = String.new
until inp == "quit" do
  puts "print_paths - 1\n" \
       "search - 2\n" \
       "smallest - 3\n" \
       "largest - 4\n" \
       "delete - 5\n" \
       "pre_order - 6\n" \
       "post_order - 7\n" \
       "in_order - 8\n" \
       "level_order - 9\n" \
       "addElemets - 10\n" \
       "quit - quit\n"
  
  inp = STDIN.gets.chomp
  puts "\e[H\e[2J"
  binary_tree.input_handler(inp)
  unless inp == "quit"
    STDIN.getch
  end
end

binary_tree.generate_level_order
File.open("binary_tree_out.txt", "w+") { |file| file.write(binary_tree.level_order_traversal.map(&:to_s).join(' ')) }