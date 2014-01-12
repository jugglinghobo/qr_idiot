# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments'

require 'haml'
require 'sass'

@@image_url = "http://i.imgur.com/dBjHVLF.png"

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
  puts "#{@@image_url}"
  @post = Post.new params[:post]
  if @post.body?
    @post.save!
    new_image_url = params[:image_url].presence || @post.image_url
    puts "NEW IMAGE URL: #{new_image_url}"
    @@image_url = new_image_url
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
  puts "SETTING IMAGE URL: #{url}"
  @@image_url = url
  puts "SET TO: #{@@image_url}"
end

def image_url
  @image_url = @@image_url
end

class Post < ActiveRecord::Base
end
