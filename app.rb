# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

require 'haml'
require 'sass'

get '/' do
  haml :new
end

post '/create' do
  @post = Post.new params[:post]
  if @post.author && @post.body
    @post.save!
    redirect '/posts'
  else
    haml :new
  end
end


get '/posts' do
  @posts = Post.all
  haml :posts
end

SASS_DIR = File.expand_path("../public/stylesheets", __FILE__)

get "/stylesheets/:stylesheet.css" do |stylesheet|
  content_type "text/css"
  template = File.read(File.join(SASS_DIR, "#{stylesheet}.scss"))
  scss template
end

class Post < ActiveRecord::Base
end
