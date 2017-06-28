require_relative '../models/robot.rb'

class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    @robots = Robot.all
    erb :index, :layout => :'layout'
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    robot = Robot.new(params[:robot])
    robot.save
    redirect'/robots'
  end

  get '/robots/:id' do |id|
    @robot = Robot.find_by_id(id.to_i)
    erb :show
  end

  get '/robots/:id/edit' do
    @robot = Robot.find_by_id(params[:id].to_i)
    erb :edit
  end

  post '/robots/:id' do |id|
    Robot.destroy(id.to_i)
    redirect "/robots"
  end

  post '/robots/:id/edit' do |id|
    Robot.update(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end


  not_found do
   erb :error
 end
end
