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
  	network = to_list(params['network'])
  	blacklist = to_list(params['blacklist'])

  	@network = to_string(network)
  	@blacklist = to_string(blacklist)

  	@network_size = calc_size(network)
  	@blacklist_size = calc_size(blacklist)

  	@result = calc_result(network, blacklist)
  	@result_size = calc_size(@result)
    erb :index
  end


