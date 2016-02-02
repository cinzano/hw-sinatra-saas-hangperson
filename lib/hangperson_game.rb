class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(letter)
    raise ArgumentError, "Null" if letter.nil?
    raise ArgumentError, "No guess" if letter.empty?
    raise ArgumentError, "Not a letter" if letter =~ /[^a-zA-Z]/
    
    letter.downcase!
    if ((@guesses.include? letter) || (@wrong_guesses.include? letter))
      return false
    end
    
    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end
  end

  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif @wrong_guesses.length > 6
      return :lose
    else
      return :play
    end
  end
  
  def word_with_guesses
    if @guesses.empty?
      return @word.gsub(/[a-z]/, '-')
    else
      new = ""
      @word.each_char do |a|
        if @guesses.include? a
          new << a
        else
          new << "-"
        end
      end
      return new
    end
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
