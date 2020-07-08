require_relative "./binary_tree.rb"

OPERATIONS_HASH = Hash.new { |h, k| h[k] = {} }

def add_operation(type, msg, category)
  OPERATIONS_HASH[category][type] = msg
  type
end

def add_category(type, msg)
  OPERATIONS_HASH[type] = { :msg => msg }
  type
end

module OperationCategory
  PRINT = add_category(1, "Print")
  MODIFY = add_category(2, "Modify")
  SEARCH = add_category(3, "Search")
end

module Operations
  PRINT_PATHS = add_operation(1, "Print all root to leaf paths", OperationCategory::PRINT)
  SMALLEST = add_operation(2, "Print the smallest element", OperationCategory::PRINT)
  LARGEST = add_operation(3, "Print the largest element", OperationCategory::PRINT)
  PRE_ORDER = add_operation(4, "Print the pre order traversal", OperationCategory::PRINT)
  POST_ORDER = add_operation(5, "Print the post order traversal", OperationCategory::PRINT)
  IN_ORDER = add_operation(6, "Print the in order traversal", OperationCategory::PRINT)
  LEVEL_ORDER = add_operation(7, "Print the level order traversal", OperationCategory::PRINT)
  SEARCH = add_operation(1, "Search an element by value", OperationCategory::SEARCH)
  ADD_ELEMENTS = add_operation(1, "Add elements to the tree (space seperated)", OperationCategory::MODIFY)
  RECURSIVE_ADD = add_operation(2, "Add elements to the tree (recursively)", OperationCategory::MODIFY)
  DELETE = add_operation(3, "Delete an element by value", OperationCategory::MODIFY)
end

module Commands
  HOME = "home"
  QUIT = "quit"
  FILE = "file"
  INPUT = "input"
end

def arr_from_file
  unless ARGV.empty?
    begin
      file = File.open(ARGV[0], "r+")
      file_data = file.read
    rescue => exception
      puts "ERROR: READ_FROM_FILE: #{exception.to_s}"
    ensure
      file.close if file
    end
    arr = file_data.split(' ').map(&:to_i)
  else
    puts "ERROR: ARGC 0"
    arr = get_arr_input
  end
  arr
end

def get_arr_input
  puts "enter the array space seperated to build binary tree \n"
  file_data = STDIN.gets.chomp.split(' ')
  file_data.each { |str| abort "Invalid Input" unless str.to_i.to_s == str }
  arr = file_data.map(&:to_i)
  arr
end

def get_initial_array
  puts "Read from the file provided (\"file\") or input new values (\"input\") "
  inp = STDIN.gets.chomp
  puts "\e[H\e[2J"
  case inp
  when Commands::FILE then arr = arr_from_file
  when Commands::INPUT then arr = get_arr_input
  else puts "please input a valid choice \n"
  end
  arr
end

def quit_operation(binary_tree)
  binary_tree.generate_level_order
  File.open("binary_tree_out.txt", "w+") { |file| file.write(binary_tree.level_order_traversal.map(&:to_s).join(' ')) }
end

def get_category
  puts "Select a category of opearion: (Eg: 1) \n"
  OPERATIONS_HASH.each { |key, option| puts "#{key}. #{option[:msg]}" }
  puts "Enter 'quit' to exit.\n"
  inp = STDIN.gets.chomp
  puts "\e[H\e[2J"
  inp
end

def get_menu_input
  category = get_category
  opt = -1
  unless category == Commands::QUIT
    puts "Select an operation to perform: (Eg: 1) \n"
    category = category.to_i
    OPERATIONS_HASH[category].each { |key, value|
      puts "#{key}. #{value}"
    }
    
    puts "Enter 'quit' to exit.\n"

    opt = STDIN.gets.chomp
    puts "\e[H\e[2J"
  end
  return category, opt.to_i
end

def print_handler(inp, binary_tree)
  if inp != Commands::QUIT
    case inp.to_i
    when Operations::PRINT_PATHS then puts binary_tree.print_paths, "\n"
    when Operations::SMALLEST then puts binary_tree.smallest.value, "\n"
    when Operations::LARGEST then puts binary_tree.largest.value, "\n"
    when Operations::PRE_ORDER then puts binary_tree.pre_order, "\n"
    when Operations::POST_ORDER then puts binary_tree.post_order, "\n"
    when Operations::IN_ORDER then puts binary_tree.in_order, "\n"
    when Operations::LEVEL_ORDER then puts binary_tree.level_order, "\n"
    else puts "enter a valid choice \n"
    end
  elsif inp == Commands::QUIT
    return false
  end
  return true
end

def modify_handler(inp, binary_tree)
  if inp != Commands::QUIT
    case inp.to_i
    when Operations::DELETE then puts binary_tree.delete_helper, "\n"
    when Operations::ADD_ELEMENTS then puts binary_tree.add_elements_helper, "\n"
    when Operations::RECURSIVE_ADD then puts binary_tree.recur_add, "\n"
    else puts "enter a valid choice \n"
    end
  elsif inp == Commands::QUIT
    return false
  end
  return true
end

def search_handler(inp, binary_tree)
  if inp != Commands::QUIT
    case inp.to_i
    when Operations::SEARCH then puts binary_tree.search_helper, "\n"
    else puts "enter a valid choice \n"
    end
  elsif inp == Commands::QUIT
    return false
  end
  return true
end

def input_handler(category, opt, binary_tree)
  if category != Commands::QUIT
    case category.to_i
    when OperationCategory::PRINT then print_handler(opt, binary_tree)
    when OperationCategory::SEARCH then search_handler(opt, binary_tree)
    when OperationCategory::MODIFY then modify_handler(opt, binary_tree)
    else puts "enter a valid choice \n"
    end
  elsif category == Commands::QUIT
    return false
  end
  return true
end

def run_operations(binary_tree)
  category, opt = get_menu_input
  ret = input_handler(category, opt, binary_tree)
  return ret
end

def quit_menu(binary_tree)
  puts "rebuild tree - home\n" \
       "quit the utility - quit\n"
  inp = STDIN.gets.chomp
  puts "\e[H\e[2J"
  case inp
  when Commands::HOME then return false
  when Commands::QUIT then quit_operation(binary_tree)
  else puts "enter a valid choice \n"
  end
  return true
end

def home
  arr = get_initial_array
  binary_tree = BinaryTree.new(arr)
  ret = run_operations(binary_tree)
  while ret
    ret = run_operations(binary_tree)
  end
  binary_tree
end

def main
  binary_tree = home
  until quit_menu(binary_tree)
    binary_tree = home
  end
end

main