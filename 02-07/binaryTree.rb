# Build a Binary tree data structure with following operations. Use OOPs concepts in this. Follow coding guidelines
# [x] Add elements into the tree(multiple elements comma separated)
# [x] Print the largest element
# [x] Print the smallest element
# [x] Print Inorder, postorder, level order, and preorder traversal
# [x] Search an element
# [x] Remove an element
# [x] Print all the paths i.e starting from root to the leaf
# [x] Script should run and serve until quit is not given as input
# [x] Write all the elements to a file on quit command 
# [x] Option to start script with a file input and load BST with integers inside that file

class BinaryTree
  attr_reader :root, :levelOrderTraversal

  def initialize(root)
    @root = root
    @levelOrderTraversal = []
  end

  def pushNode(node = @root, value)
    if (value >= node.value)
        if node.right
            pushNode(node.right, value)
        else
            node.right = Node.new(value)
        end
    else
        if node.left
            pushNode(node.left, value)
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

  def inOrder(node = @root)
    if (node == nil)
      return
    end

    inOrder(node.left)

    print(node.value, " ")

    inOrder(node.right)
  end

  def postOrder(node = @root)
    if (node == nil)
      return
    end

    postOrder(node.left)

    postOrder(node.right)

    print(node.value, " ")
  end

  def preOrder(node = @root)
    if (node == nil)
      return
    end

    print(node.value, " ")

    preOrder(node.left)

    preOrder(node.right)
  end

  def levelOrder(node = @root)
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

  def generateLevelOrder(node = @root)
    if (node == nil)
      return
    end

    que = []
    que << @root

    while (!que.empty?) do
      node = que.shift
      @levelOrderTraversal << node.value

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
      temp = smallest(node.right) # find the inorder successor
      node.value = temp.value # copy inorder successor's value
      node.right = delete(node.right, temp.value) # delete the inorder successor node
    end

    generateLevelOrder
    node
  end

  def printArray(paths, pathLen)
    (0..pathLen-1).each { |i| print(paths[i], " ")}
    print("\n")
  end

  def printPathsRecur(node, paths, pathLen)
    if node.nil?
      return
    end

    paths[pathLen] = node.value
    pathLen += 1

    if (node.left.nil? && node.right.nil?)
      printArray(paths, pathLen)
    else
      printPathsRecur(node.left, paths, pathLen)
      printPathsRecur(node.right, paths, pathLen)
    end
  end

  def printPaths(node = @root)
    paths = Array.new(1000)
    printPathsRecur(node, paths, 0)
  end

  def searchHelper
    puts "enter number to search "
    inp_int = (STDIN.gets.chomp).to_i
    if search(inp_int)
      puts "Found"
    else
      puts "Missing"
    end
  end

  def deleteHelper
    puts "enter number to delete "
    inp_int = (STDIN.gets.chomp).to_i
    return delete(inp_int)
  end

  def addElementsHelper
    puts "enter numbers to add to the tree (space seperated) \n"
    file_data = STDIN.gets.chomp
    arr = file_data.split(' ').map(&:to_i)
    arr.each { |n| pushNode(n) }
    generateLevelOrder
    return
  end

  def inputHandler(inp)
    if inp == "quit"
    else
      case inp.to_i
      when 1 then puts printPaths, "\n"
      when 2 then puts searchHelper, "\n"
      when 3 then puts smallest.value, "\n"
      when 4 then puts largest.value, "\n"
      when 5 then puts deleteHelper, "\n"
      when 6 then puts preOrder, "\n"
      when 7 then puts postOrder, "\n"
      when 8 then puts inOrder, "\n"
      when 9 then puts levelOrder, "\n"
      when 10 then puts addElementsHelper, "\n"
      else puts "enter a valid choice "
      end
    end
  end
end

class Node
  attr_reader :value
  attr_accessor :left, :right

  def initialize(value)
      @value = value
      @left = nil
      @right = nil
  end
end

unless ARGV.empty?
  file = File.open(ARGV[0])
  file_data = file.read
  file.close
  arr = file_data.split(' ').map(&:to_i)
  # arr = [5, 6, 2, 4, 1, 8, 7, 9, 3]
  root = Node.new(arr.shift)
  binaryTree = BinaryTree.new(root)
  arr.each { |n| binaryTree.pushNode(n) }
  binaryTree.generateLevelOrder
else
  puts "enter the array space seperated to build binary tree \n"
  file_data = STDIN.gets.chomp
  arr = file_data.split(' ').map(&:to_i)
  root = Node.new(arr.shift)
  binaryTree = BinaryTree.new(root)
  arr.each { |n| binaryTree.pushNode(n) }
  binaryTree.generateLevelOrder
end

inp = String.new
until inp == "quit" do
  puts "printPaths - 1\n" \
       "search - 2\n" \
       "smallest - 3\n" \
       "largest - 4\n" \
       "delete - 5\n" \
       "preOrder - 6\n" \
       "postOrder - 7\n" \
       "inOrder - 8\n" \
       "levelOrder - 9\n" \
       "addElemets - 10\n" \
       "quit - quit\n"
  
  inp = STDIN.gets.chomp
  puts "\e[H\e[2J"
  binaryTree.inputHandler(inp)
end

File.open("binaryTreeOUT.txt", "w") { |file| file.write(binaryTree.levelOrderTraversal.map(&:to_s).join(' ')) }