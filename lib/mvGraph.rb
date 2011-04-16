class Graph
  
  def initialize
    @adj_list = Hash.new
  end
  
  def add_vertex(v)
    @adj_list[v] = Array.new
  end
  
  def vertex(v)
    @adj_list[v]
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
  
  def bfs(start_vertex)
    @adj_list.keys.each do |vertex|
    end
  end
  
  def set_vertex_color(v, color)
    @adj_list.keys[@adj_list.keys.index(v)].color = color
  end

  def get_vertex_color(v)
    @adj_list.keys[@adj_list.keys.index(v)].color
  end
  
  def set_vertex_distance(v, distance)
    @adj_list.keys[@adj_list.keys.index(v)].distance = distance
  end

  def get_vertex_distance(v)
    @adj_list.keys[@adj_list.keys.index(v)].distance
  end
  
  def set_vertex_predecessor(v, predecessor)
    @adj_list.keys[@adj_list.keys.index(v)].predecessor = predecessor
  end

  def get_vertex_predecessor(v)
    @adj_list.keys[@adj_list.keys.index(v)].predecessor
  end
  
end

class Vertex
  attr_accessor :id
  attr_accessor :color
  attr_accessor :distance
  attr_accessor :predecessor
  
  def initialize(id)
    @id = id
    @color = "white"
    @distance = 2**32
    @predecessor = nil
  end
  
  def ==(other_vertex)
    @id == other_vertex.id
  end
  
  def eql?(other_vertex)
    @id == other_vertex.id
  end
  
  def hash
    @id.hash
  end
  
end

class Edge
  
end
