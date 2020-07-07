module TreeOperations
  STOP = "stop"

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
end