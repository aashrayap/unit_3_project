Attributes=Struct.new(:classes,:id,:name)

class Parsing
  def initialize
  	@attributes_array=[]
  end

  def main
  	#creting new array with all the lines in the html file
  	@array_of_lines=File.readlines('main.html')

  	#parsing each line of our array into the data structure (struct)
  	@array_of_lines.each do |line,index|
  	  parse_tag(line)
  	end

  end

  def parse_tag(tag)
  	if tag.include?('class') || tag.include?('id')
	  attributes1=Attributes.new
  	end

  	#placing class type into attribute.classes
  	if tag.include?('class')
	  matching_class = tag.match (/class=['"](.+?)['"]/)
	  attributes1.classes=matching_class.captures[0].split(' ')
  	end

  	#placing id type into attribute.id
  	if tag.include?('id')
	  matching_id = tag.match (/id=['"](.+?)['"]/)
	  attributes1.classes=matching_id.captures
  	end

  	if tag.include?('class') || tag.include?('id')
	@attributes_array<<attributes1
  	end
  end
 

end


p=Parsing.new
p.main
