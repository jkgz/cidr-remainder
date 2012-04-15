require 'netaddr'

def calc_remainder(network, blacklist_addr)
	network.sort! {|a,b| b.size <=> a.size}
	network.each do |addr|
		if addr.contains?(blacklist_addr.network)
			(network << addr.remainder(blacklist_addr, :Objectify => true)).flatten!.delete(addr)
			break
		end
	end

	return network
end

def read_file(filename)
	return IO.readlines(filename)
end

def to_list(input_string)
	list = input_string.split("\r\n")
	list.map!(&:strip)
	list.reject!(&:empty?)
	return list
end

def to_string(input_array)
	return input_array.join("\r\n")
end

def to_cidr_list(list)
	#TODO: would be better to do auto-detection of addr_type, but this will do for now.
	addr_type = "cidr"

	if addr_type == "cidr"
		cidr_list = list.map {|item| NetAddr::CIDR.create(item)} 
	elsif addr_type == "wildcard"
		cidr_list = list.map {|item| NetAddr.wildcard(item)}
	end
	
	return cidr_list
end

def calc_result(network, blacklist)
	#network = read_file("network.txt")
	#blacklist = read_file("blacklist.txt")

	network = to_cidr_list(network)
	blacklist = to_cidr_list(blacklist)
	blacklist.each do |blacklist_addr|
		network = calc_remainder(network, blacklist_addr)
	end

	return NetAddr.merge(network)
end

def calc_size(network)
	network = to_cidr_list(network)
	return network.map(&:size).reduce(:+)
end

# TODO: the code to support input ranges for whitelist/blacklist would use NetAddr.range and then .merge that down into CIDR blocks
# would need to do some easy string parsing work to parse out input lines that look like "192.168.35.0-192.168.36.3"
=begin
ip_net_range = NetAddr.range('192.168.35.0','192.168.36.3',:Inclusive => true, :Objectify => true)
result = NetAddr.merge(ip_net_range, :Objectify => true)
=end
