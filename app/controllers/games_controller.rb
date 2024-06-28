require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @user_input = params[:user_input]
    # need to access the letters back from the form
    @letters = params[:letters].split('')
    url = "https://dictionary.lewagon.com/#{@user_input}"
    response = URI.open(url).read
    result = JSON.parse(response)
    letters_to_compare = @user_input.split('')

    # need to compare letters and user input somehow...

    # to compare if letters in result are in the letters tiles array
    all_letters_present = letters_to_compare.all? { |letter| @letters.include?(letter) }

    if all_letters_present == false
      @message = "Sorry but <b>#{@user_input}</b> can't be built out of #{@letters}".html
    else
      if result['found'] == false
        logger.debug(url)
        @message = "Sorry, but <b>#{@user_input.upcase}</b> does not seem to be a valid English word.".html_safe
      else
        logger.debug(url)
        @message = "Congratulations! <strong>#{@user_input.upcase}</strong> is a valid English word!".html_safe
      end
    end
  end
end
