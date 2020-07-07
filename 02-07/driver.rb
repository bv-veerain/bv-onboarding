require_relative "./binary_tree.rb"

module Operations
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
  RECURSIVE_ADD = 11
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

def get_menu_input
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
       "recursiveAdd - 11\n" \
       "quit - quit\n"
  
  inp = STDIN.gets.chomp
  puts "\e[H\e[2J"
  inp
end

def input_handler(inp, binary_tree)
  if inp != Commands::QUIT
    case inp.to_i
    when Operations::PRINT_PATHS then puts binary_tree.print_paths, "\n"
    when Operations::SEARCH then puts binary_tree.search_helper, "\n"
    when Operations::SMALLEST then puts binary_tree.smallest.value, "\n"
    when Operations::LARGEST then puts binary_tree.largest.value, "\n"
    when Operations::DELETE then puts binary_tree.delete_helper, "\n"
    when Operations::PRE_ORDER then puts binary_tree.pre_order, "\n"
    when Operations::POST_ORDER then puts binary_tree.post_order, "\n"
    when Operations::IN_ORDER then puts binary_tree.in_order, "\n"
    when Operations::LEVEL_ORDER then puts binary_tree.level_order, "\n"
    when Operations::ADD_ELEMENTS then puts binary_tree.add_elements_helper, "\n"
    when Operations::RECURSIVE_ADD then puts binary_tree.recur_add, "\n"
    else puts "enter a valid choice \n"
    end
  elsif inp == Commands::QUIT
    return false
  end
  return true
end

def run_operations(binary_tree)
  inp = get_menu_input
  ret = input_handler(inp, binary_tree)
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