# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

require 'haml'
require 'sass'

get '/' do
  @posts = Post.all
  haml :posts
end

post '/create' do
  nw = preprocess_params
  @post = Post.new params[:post]
  if @post.body?
    @post.save!
    redirect '/'
  else
    redirect '/new'
  end
end


get '/new' do
  haml :new
end

SASS_DIR = File.expand_path("../public/stylesheets", __FILE__)
get "/stylesheets/:stylesheet.css" do |stylesheet|
  content_type "text/css"
  template = File.read(File.join(SASS_DIR, "#{stylesheet}.scss"))
  scss template
end

def preprocess_params
  puts "before: #{params.inspect}"
  params[:post].delete_if {|k, v| v.empty? }
  puts "after: #{params.inspect}"
end

class Post < ActiveRecord::Base
end
