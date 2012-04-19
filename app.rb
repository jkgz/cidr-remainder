require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'erb'
require './model/network'
require './helpers/helpers'


  get '/' do
  	@network = Helpers.to_multiline_string(Array.[]('10.4.0.0/16', '172.*.*.*', '210.10.4.0-210.10.5.255'))
  	@blacklist = Helpers.to_multiline_string(Array.[]('10.4.99.0/24', '10.4.100.*', '172.6.*.*', '210.10.5.0-210.10.5.127'))
    erb :index 
  end

  post '/' do
  	network = Helpers.from_multiline_string(params['network'])
  	blacklist = Helpers.from_multiline_string(params['blacklist'])
    result = get_remainder(network, blacklist)

  	@network = Helpers.to_multiline_string(network)
  	@blacklist = Helpers.to_multiline_string(blacklist)
  	@result = result

    @network_size = get_size(network)
    @blacklist_size = get_size(blacklist)
  	@result_size = get_size(result)

    erb :index
  end


