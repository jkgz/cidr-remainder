
module Helpers
  def self.to_multiline_string(input_array)
	return input_array.join("\r\n")
  end

  def self.from_multiline_string(input_string)
  	return input_string.split()
 end
end
