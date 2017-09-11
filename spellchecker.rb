class SpellChecker
  def initialize(dictionary)
    @dictionary = Dictionary.new(dictionary)
    @counter = 0
    @cursor = @dictionary.root
  end

  def suggest_words(prefix)
    @prefix_node = get_node_at_end_of_prefix(prefix)
    @cursor = @prefix_node
    @chars_in_current_word = [prefix]
    get_word(@prefix_node)
    puts("#{@counter} words have prefix #{prefix}")
  end

  def get_word(node)
    if node.children.nil?
      @chars_in_current_word.pop
      return
    end

    node.children.each_with_index do |child_node, idx|
      next if child_node.nil?
      @cursor = child_node
      @chars_in_current_word << get_char(idx)
      if child_node.is_word == true
        @counter += 1
        File.open('words_with_prefix.txt', 'a') { |f| f.puts @chars_in_current_word.join }
      end
      get_word(@cursor)
    end

    @chars_in_current_word.pop
  end

  def get_char(idx)
    return "'" if idx == 26
    (idx + 97).chr
  end

  def get_node_at_end_of_prefix(prefix)
    prefix.downcase.each_char do |char|
      if @cursor.nil? || @cursor.children.nil? || @cursor.children[get_dict_index(char)].nil?
        puts("Prefix #{prefix} not present in dictionary")
        exit
      else
        @cursor = @cursor.children[get_dict_index(char)]
      end
    end
    @cursor
  end

  def spellcheck_lines(text)
    IO.foreach(text) do |line|
      split_into_words(line).each do |word|
        next if word.chomp == ''
        if word_in_dictionary?(word.chomp) == false
          @counter += 1
          File.open('misspelled_words.txt', 'a') { |f| f.puts(word) }
        end
      end
    end

    puts("# of misspelt words: #{@counter}")
  end

  def split_into_words(line)
    line.scan(/[a-zA-Z']*/)
  end

  private
  def word_in_dictionary?(word)
    @cursor = @dictionary.root
    word.downcase.each_char do |char|
      if @cursor.nil? || @cursor.children.nil? || @cursor.children[get_dict_index(char)].nil?
        return false
      else
        @cursor = @cursor.children[get_dict_index(char)]
      end
    end
    @cursor.is_word
  end

  def get_dict_index(char)
    return 26 if char == "'"
    char.ord - 97
  end
end
