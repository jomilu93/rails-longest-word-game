require 'json'
require 'open-uri'

class GamesController < ApplicationController
attr_accessor :game_letters

  def new
    @all_letter = Array('A'..'Z')
    @game_letters = @all_letter.sample(10)
  end

  def score
    @input_word = params[:word]
    @input_word_letters = @input_word.chars

    @word_test_url = "https://wagon-dictionary.herokuapp.com/#{@input_word}"
    @word_test_raw = open(@word_test_url).read
    @word_test = JSON.parse(@word_test_raw)['found']
    @word_score = JSON.parse(@word_test_raw)['length']


    if @word_test
      @input_word_letters.each do |letter|
        if params[:letters].include?(letter)
          next
        else
          "Sorry, you cannot use letter that are not in the list.."
        end
      end
      "Congratulations! Your score is: #{@word_score}"
    else
      "Sorry, that word does not appear to be a valid english word..."
    end
  end

  helper_method :score
end

