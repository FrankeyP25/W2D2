class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  def self.random_word
    DICTIONARY.sample
  end

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def initialize
    @secret_word = Hangman.random_word # => string
    @guess_word = Array.new(@secret_word.length, "_") # => array with length of string 
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    (0...@secret_word.length).select { |i| @secret_word[i] == char }
  end

  def fill_indices(char, indices)
  indices.each { |i| @guess_word[i] = char }
  end

  #part 2

  def try_guess(char)
    if self.already_attempted?(char)
      puts "that has already been attempted"
      return false
    end

    @attempted_chars << char

    mathces = self.get_matching_indices(char)
    self.fill_indices(char, mathces)
    @remaining_incorrect_guesses -= 1 if mathces.empty?

    true
  end

  def ask_user_for_guess
    puts "Enter a char: "
    char = gets.chomp
    
    self.try_guess(char)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses > 1
      false
    else
      puts "LOSE"
      true
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      true
    else
      false
    end
  end
end
