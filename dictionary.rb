class Dictionary
  attr_reader :root

  def initialize(file)
    @root = Node.new
    @cursor = @root
    @counter = 0
    add_words(file)
  end

  def add_words(file)
    IO.foreach(file) do |word|
      add_word(word.chomp)
      @counter += 1
    end
    puts("Added #{@counter} words into the dictionary")
  end

  private
  def add_word(word)
    set_cursor_to_root

    word.downcase.each_char do |char|
      if @cursor.children.nil?
        @cursor.children = Array.new(27)
        @cursor.children[get_dict_index(char)] = Node.new
      elsif @cursor.children[get_dict_index(char)].nil?
        @cursor.children[get_dict_index(char)] = Node.new
      end
      move_cursor_to_next_node(char)
    end

    @cursor.is_word = true
  end

  def get_dict_index(char)
    return 26 if char == "'"
    char.ord - 97
  end

  def set_cursor_to_root
    @cursor = @root
  end

  def move_cursor_to_next_node(char)
    @cursor = @cursor.children[get_dict_index(char)]
  end
end
