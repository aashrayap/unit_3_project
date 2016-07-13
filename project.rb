
Node=Struct.new(:tag,:text,:class,:id,:children,:parent)

class Reader 
  def initialize
  	@document=File.readlines('main.html')
    build_tree
  end
  attr_accessor :root

  def build_tree
  	@root=Node.new('document',nil,nil,nil,[],nil)
  	@pointer=@root
  	@num_nodes=1

  	@document.each do |line|
  	  create_nodes(line)
 	  end
  end

  def create_nodes(line)
    @num_nodes+=1
  	test_node=parse_line(line)
  	if line.include?('<') && !line.include?('</')
  	  @pointer.children<<Node.new(test_node.tag,test_node.text,test_node.class,test_node.id,[],@pointer)
  	  @pointer=@pointer.children[-1]
  	end

  	if line.include?('/<')
  	  @pointer=@pointer.parent
  	end

  	if !line.include?('<')
  	  @pointer.text=test_node.text
  	end
  end

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


