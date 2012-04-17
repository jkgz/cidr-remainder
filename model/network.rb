require 'netaddr'

def get_remainder(network, blacklist)

	network = to_cidr_list(network)
	blacklist = to_cidr_list(blacklist)
	
	blacklist.each do |blacklist_addr|
		network.sort! {|a,b| b.size <=> a.size}
		network.each do |addr|
			if addr == blacklist_addr
				network.delete(addr)
			elsif addr.contains?(blacklist_addr.network)
				(network << addr.remainder(blacklist_addr, :Objectify => true)).flatten!.delete(addr)
				break
			end
		end
	end

	return NetAddr.merge(network)
end

def get_size(network)
	return to_cidr_list(network).map(&:size).reduce(:+)
end

private
def to_cidr_list(list)
	cidr_list = list.reduce([]) do |result, element|
		if element.include?("*")
			result << NetAddr.wildcard(element)
		elsif element.include?("-")
			range_addrs = element.split("-")
			ip_range = NetAddr.range(range_addrs[0],range_addrs[1],:Inclusive => true, :Objectify => true)
			(result << NetAddr.merge(ip_range, :Objectify => true)).flatten!
		else
			result << NetAddr::CIDR.create(element)
		end	
		result
	end

	return cidr_list
end

