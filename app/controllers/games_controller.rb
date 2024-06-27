class GamesController < ApplicationController
  def new
    @user_input = params[:input]
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @url = "https://dictionary.lewagon.com/#{params[:input]}"
  end
end
