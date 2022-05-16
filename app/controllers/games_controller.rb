require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
  # afficher une nouvelle grille aléatoire et un formulaire
    letter = [*('a'..'z')]
    @letters = []
      for i in 1..10
        @letters << letter.sample
      end
    return @letters
  end

  def score
  # Le formulaire sera envoyé (avec POST) à l’action score
    @word = params[:word]
    @score = 0

  # Si le mot est dans le dictionnaire et s'il est valide
    if in_the_grid?(@word, @letters)
      if (in_the_dico?(@word) == "true")
        @score = @word.length
        @message = "Congratulations! #{@word} is a valid English word!"
      else
        @message = "Sorry but #{@word} does not seem to be a valid English word..."
        @score = 0
      end
    else
      @message = "Sorry but #{@word} can't be built out of #{@letters.upcase}"
      @score  = 0
    end
  end

  private

  def in_the_grid?(word, grid)
    attempt_letters = word.split(//)
    result = true
    attempt_letters.each do |elem|
      if !grid.include?(elem)
        includes = false
      end
    end
  end

  def in_the_dico?(word)
    url = "https://wagon-dictionary.herokuapp.com/"+#{word}
    dico_serialized = URI.open(url).read
    dico = JSON.parse(dico_serialized)
    return dico[:found].to_s
  end
end
