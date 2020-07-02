class Book
    attr_reader :title, :author # this allows read access for title and author

    # attr_reader (read-only)
    # attr_writer (write-only)
    # attr_accessor (read & write) # both read and write

    @@count = 0

    def initialize(title, author) # this is the constructor method in ruby
        @title  = title
        @author = author
        @@count += 1
    end

    def self.count
        @@count
    end

    def what_am_i
        puts "I am a book"
    end

    def who_am_i
        puts "I am a book. My name is #{@title} and I'm written by #{author}"
    end
end

deep_dive = Book.new("Ruby Deep Dive", "Jesus Castello")
fun = Book.new("Fun With Programming", "White Cat")
puts deep_dive.title
puts Book.count