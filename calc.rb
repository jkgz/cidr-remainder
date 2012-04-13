require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra/base'
require 'erb'

class MyApp < Sinatra::Base
  get '/' do
    @foo = 'click the button'
    erb :index
  end

  post '/' do
  	    @foo = 'result'
    erb :index
  end
end

MyApp.run!