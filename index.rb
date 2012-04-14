require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'erb'
require './calc-cidr-whitelist'


  get '/' do
  	@network = '10.0.0.0/8'
  	@blacklist = '10.3.0.0/16'
    erb :index
  end

  post '/' do
  	network = params['network']
  	blacklist = params['blacklist']

  	@network = network
  	@blacklist = blacklist
  	@result = calc_result(network.split("\r\n"), blacklist.split("\r\n"))
    erb :index
  end


