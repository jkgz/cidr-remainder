require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'erb'
require './calc-cidr-whitelist'


  get '/' do
  	@network = to_string(Array.[]('10.0.0.0/8', '10.3.3.32/32'))
  	@blacklist = to_string(Array.[]('10.4.0.0/16', '10.3.0.0/16'))
    erb :index
  end

  post '/' do
  	network = to_array(params['network'])
  	blacklist = to_array(params['blacklist'])

  	@network = to_string(network)
  	@blacklist = to_string(blacklist)
  	@result = calc_result(network, blacklist)
    erb :index
  end


