require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    # to display new random grid and a form
    # form post to score action
    @time_start = Time.now
    letters = "abcdefghijklmnopqrstuvwxyz"
    @array = []
    10.times { @array << letters[rand(1..25)] }
    @array
  end

  def check_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    # url = "https://wagon-dictionary.herokuapp.com/test"
    hash = JSON.parse(URI.open(url).read)
    hash["found"]
  end

  def check_array(word, array)
    word.split.all? { |char| array.include?{char} }
  end

  def score
    word = params[:word]
    array = params[:array]
    time_taken = params[:time]
    @message = ''
    dict_result = check_word(word)
    # array_result = check_array(word, array)
    array_result = word.split('').all? { |char| array.include?(char) }
      if array_result == false
        @message = "word can't be formed from array"
      else
        if dict_result == false
          @message = "Sorry but #{word} does not exist in the dictionary!"
        else
          @message = "Congrats, #{word} is a valid English word!"
        end
      end
    @message
    @score = word.length + time_taken.to_f * 1000
  end
end
