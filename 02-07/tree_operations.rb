module TreeOperations
  STOP = "stop"

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
end