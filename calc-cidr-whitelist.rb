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

def read_cidr_from_file(filename)
	#TODO: would be better to do auto-detection of input_type, but this will do for now.
	input_type = "cidr"

	network = IO.readlines(filename)
	network.map! {|item| item.strip}

	if input_type == "cidr"
		network.map! {|item| NetAddr::CIDR.create(item)} 
	elsif input_type == "wildcard"
		network.map! {|item| NetAddr.wildcard(item)}
	end
	
	return network
end

network = read_cidr_from_file("network.txt")
blacklist = read_cidr_from_file("blacklist.txt")

blacklist.each do |blacklist_addr|
	network = calc_remainder(network, blacklist_addr)
end

puts "Result"
network = NetAddr.merge(network)
puts network


# TODO: the code to support input ranges for whitelist/blacklist would use NetAddr.range and then .merge that down into CIDR blocks
# would need to do some easy string parsing work to parse out input lines that look like "192.168.35.0-192.168.36.3"
=begin
ip_net_range = NetAddr.range('192.168.35.0','192.168.36.3',:Inclusive => true, :Objectify => true)
result = NetAddr.merge(ip_net_range, :Objectify => true)
=end
