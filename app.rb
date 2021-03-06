require 'sinatra/base'
require './lib/opponent.rb'
require './lib/turn.rb'

class RPS < Sinatra::Base
  enable :sessions
  get '/' do 
    erb :index
  end

  post '/name' do
    session[:player_name] = params[:name]
    redirect '/play'
  end
  
  get '/play' do
    @turn = Turn.new(session)
    # @name = session[:name]
    # @shape = session[:shape]
    # @opponent_shape = session[:opponent_shape]
    erb :play 
  end

  post '/play' do
    session[:player_shape] = params[:shape].downcase.to_sym
    session[:opponent_shape] = Opponent.new.shape
    redirect '/play'
  end

# start the server if ruby file executed directly
  run! if app_file == $0
end
