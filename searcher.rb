require './project.rb'

class Searcher
  def initialize(tree)
  	@tree=tree
  	@cursor=tree.root
  end

  #depth first search through tree for specific attribute and its value
  def dfs(attribute,value)
  	dfs_array=[]
  	dfs_array<<@cursor

  	#until stack is empty, continue looping
	while !dfs_array.empty?
	 	checker=dfs_array.pop
	  	unless checker.class.nil?
		  if attribute=="class" && checker.class.include?(value)
		  	puts "found #{value} !!!"
		  end
	  	end

	 	unless checker.id.nil?
		  if attribute=="id" && checker.id.include?(value)
		   puts "found #{value} !!!"
		  end
		end

		unless checker.class.nil?
          if attribute=="tag" && checker.tag.include?(value)
              puts "found #{value}"
          end
        end

        unless checker.text.nil?
	     if attribute=="text" && checker.text.include?(value)
	        puts "Found #{value}"
	     end
     	end

	  	checker.children.each do |child_of_child|
	  		dfs_array<<child_of_child
	  	end
	end
  end
end

tree=Reader.new
searcher=Searcher.new(tree)
searcher.dfs("id","main-area")
searcher.dfs("tag","div")
searcher.dfs("class","emphasized")