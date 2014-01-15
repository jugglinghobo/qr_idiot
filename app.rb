# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

require 'haml'
require 'sass'

DEFAULT_URL = "http://i.imgur.com/dBjHVLF.png"

get '/' do
  image_url
  haml :new
end


get '/posts' do
  @posts = Post.order("created_at DESC")
  haml :posts
end

post '/create' do
  preprocess_params
  @post = Post.new params[:post]
  if @post.body?
    @post.save!
    new_image_url = params[:image_url].match(/.*(jpg|png|gif)$/) ? params[:image_url] : @post.image_url
    self.image_url = new_image_url
    redirect '/posts'
  else
    redirect '/'
  end
end


SASS_DIR = File.expand_path("../public/stylesheets", __FILE__)
get "/stylesheets/:stylesheet.css" do |stylesheet|
  content_type "text/css"
  template = File.read(File.join(SASS_DIR, "#{stylesheet}.scss"))
  scss template
end

def preprocess_params
  params[:post].delete_if {|k, v| v.empty? }
  params[:post][:image_url] ||= image_url
end

def image_url=(url)
  @@image_url = url
end

def image_url
  @image_url = (@@image_url ||= DEFAULT_URL)
end

class Post < ActiveRecord::Base
end
