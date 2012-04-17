require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'erb'
require './model/network.rb'


  get '/' do
  	@network = to_string(Array.[]('10.4.0.0/16', '172.*.*.*'))
  	@blacklist = to_string(Array.[]('10.4.99.0/24', '10.4.100.*', '172.6.*.*'))
    erb :index
  end

  post '/' do
  	network = to_list(params['network'])
  	blacklist = to_list(params['blacklist'])

  	@network = to_string(network)
  	@blacklist = to_string(blacklist)

  	@network_size = calc_size(network)
  	@blacklist_size = calc_size(blacklist)

  	@result = get_remainder(network, blacklist)
  	@result_size = calc_size(@result)
    erb :index
  end


