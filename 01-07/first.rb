# -------------BASIC VARIABLES--------------

# age = 32
# multiplier = 10
# # print(age*multiplier, "\n")
# puts age*multiplier


# ------------VARIABLE TYPES----------------

# global variable ($apple)
# instance variable (@apple)
# class variable (@@apple)
# constant (APPLE)

# apple.class # to check it's variable type


# -------------STRINGS------------------

# food = "bacon"
# puts food
# puts food.size
# puts food.upcase

# food = food.gsub("acon", "inary")
# print(food.chars, "\n")

# ad = "1"+"1"
# # puts ad
# ad = ad.to_i
# bc = ad.to_s
# print(ad, "\n", bc, "\n")

# String Interpolation

# age = 20
# name = "David"
# puts "Hello #{name}, our records tell us you're #{age} years old!"

# ---SPLIT---

# hel = "hello you old dawg"
# puts hel.split('', 5) # split(pattern, limit) -> array
# the papttern is the splitting point or the delimitter.
# the limit is the max elements allowed in the returned array. it will join the last element to all the other items if it has to.

# ---JOIN---

# hel = ["waddup", "you", "old", "man"]
# hel = hel.join(' ') # join(pattern) -> string
# puts hel
# the pattern is the delimitter to be added to the end of each element when joining the array

#-------------------------ARRAYS------------------

# ad = [1,2,3,4,5]
# print(ad[5].to_s) # should return 'nil'

# # that's how you add numbers to the array
# numbers = []
# numbers << 1
# numbers << 2
# numbers << 3
# puts numbers


# ------------------------DICTIONARIES or HASH--------------------

# ip_to_domain = {
#     "rubyguides.com" => "185.14.187.159",
#     "openDNS" => "8.8.8.8"
# }
# # puts ip_to_domain
# puts ip_to_domain["rubyguides.com"]

# options = Hash.new(0) # creates a new hash with a default value as 0
# options["font"] = 34
# puts options["font"]

# opt = Hash.new # creates a new hash
# opt = {font_size: 24}
# puts opt[:font_size]
# not necessary to use strings as keys


# --------------------------CONDITIONALS--------------------------

# stocks = 10

# if stocks < 5
#     puts "buy more stocks"
# elsif stocks==5
#     puts "panik 1000"
# else
#     puts "pesa hi pesa"
# end

# stocks-=6

# unless stocks < 5
#     puts "pesa hi pesa"
# else
#     puts "kya hi kar sakte hai"
# end

# if (50 <=> 50) == -1
#     puts "greater than"
# elsif (50 <=> 50) == 0
#     puts "equal"
# else
#     puts "less than"
# end


# ---------------SPECIAL SYMBOLS-------------

# new line and tab are the special symbols that are included in a string

# name = gets
# p name # prints the string as it is, including special characters

# to remove the special characters, we use a function called chomp

# name = name.chomp
# p name


# ----------------CONDITIONAL SHORTHANDS-----------

# puts 123 if 2.even?
# puts 40>100 ? "Greater than" : "Less than"


# ----------------LOOPS--------------------

# ---EACH---

# numbers = [1,3,4,5,7]
# numbers.each{ |a| # the variable that gets the value at each iteration
#     if a%2==0
#         puts "even"
#     else
#         puts a
#     end
# }

# hash = {bacon: 300, coconut: 200}
# hash.each { |key, value|
#     puts "#{key} price is #{value}"
# }

# ---EACH WITH INDEX---

# animals = ["cats", "dogs", "girraffes"]
# animals.each_with_index { |animal, idx|
#     puts "we have a #{animal} at index #{idx}"
# }

# ---TIMES---

# 10.times { |i| puts "hello #{i}"}
# (3..10).each { |i| puts i } # range inclusive

# ---WHILE---

# n=0
# while n<10
#     puts n
#     n+=1
# end

# ---UNTIL---

# bottle = 0
# until bottle == 10
#     puts bottle
#     bottle+=1
# end

# ----NEXT, DO & BREAK----

# 10.times do |i|
#     next unless i.even?
#     puts "hello #{i}"
# end

# above block is same as below

# 10.times { |i|
#     next unless i.even?
#     puts "hello #{i}"
# }

# numbers = [2,3,4,5,6,17,8,19]

# numbers.each do |n|
#     break if n>10
#     puts n
# end

# ---UPTO---

# 1.upto(5) do |n|
#     puts n
# end

# -----------------RUBY GEMS-----------------

# Ruby gems are small Ruby applications that you can add into your program & they’ll help you do something.

# Nokogiri helps you read HTML code & extract information from it.
# Thor helps you write command-line applications.
# RSpec & Minitest help you write tests to check if your code is working correctly.