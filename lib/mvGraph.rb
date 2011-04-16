class Graph
  
  def initialize
    @adj_list = Hash.new
  end
  
  def add_vertex(v)
    @adj_list[v.id] = Array.new
  end
  
  def vertex(id)
    @adj_list[id]
  end
  
  def add_edge(v1, v2)
    @adj_list[v1] << v2
    @adj_list[v2] << v1
  end
  
  def has_edge?(v1, v2)
    unless @adj_list[v1].nil? and @adj_list[v2].nil?
      @adj_list[v1].include? v2 and @adj_list[v2].include? v1
    end
  end
  
  def bfs_search(start_vertex)
    @adj_list.each do |vertex|
        
    end
  end
  
  def color_vertex(id, color)
    #vertex(id).color(color)
  end
  
end

class Vertex
  attr_accessor :id
  
  def initialize(id)
    @id = id
  end
end

class Edge
  
end
