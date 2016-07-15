
Node=Struct.new(:tag,:text,:class,:id,:children,:parent)

class Reader 
  #read through each line of the file and store it in an array to access later
  def initialize
  	@document=File.readlines('main.html')
    build_tree
  end
  attr_accessor :root

#builds html file tree
  def build_tree
    #create root node
  	@root=Node.new('document',nil,nil,nil,[],nil)
    #set initial pointer to root
  	@pointer=@root
  	@num_nodes=1
    #for each line, create a node at a certain level depending on the html
  	@document.each do |line|
  	  create_nodes(line)
 	  end
  end

  def create_nodes(line)
    #increase count of nodes by 1
    @num_nodes+=1
    #parse line to test where to create node (child or sister or parent)
  	test_node=parse_line(line)
    #if new nest, create child and set pointer to it
  	if line.include?('<') && !line.include?('</')
  	  @pointer.children<<Node.new(test_node.tag,test_node.text,test_node.class,test_node.id,[],@pointer)
  	  @pointer=@pointer.children[-1]
  	end
    #if nest ends, set pointer as parent
  	if line.include?('/<')
  	  @pointer=@pointer.parent
  	end
    #if nest end or begin, place text in sister to current node
  	if !line.include?('<')
  	  @pointer.text=test_node.text
  	end
  end

  #check what the HTML reads for tree to create properly
  def parse_line(line)
    test_node=Node.new(nil,nil,nil,nil,nil,nil)
    if line.include?('<')
      matching_tag = line.match (/[<](.+?)[ ]/)
      test_node.tag=matching_tag.to_s
    end

    if line.include?('class')
      matching_class = line.match (/class=['"](.+?)['"]/)
      test_node.class=matching_class.to_s
    end

    if line.include?('id')
    matching_id = line.match (/id=['"](.+?)['"]/)
    test_node.id=matching_id.to_s
    end

    if !line.include?('<')
      test_node.text=line
    end

    return test_node
  end

  def render
    puts "You have #{@num_nodes} nodes"
  end
end


