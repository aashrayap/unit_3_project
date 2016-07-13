require './project.rb'

class Searcher
  def initialize(tree)
  	@tree=tree
  	@cursor=tree.root
  end

  def dfs(attribute,value)
  	dfs_array=[]
  	dfs_array<<@cursor

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