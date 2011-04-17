class Graph
  include Enumerable
  
  def each
    @adj_list.keys.each do |vertex|
      yield vertex
    end
  end
  
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
    set_vertex_color(start_vertex, "gray")
    set_vertex_distance(start_vertex, 0)
    queue = [get_graph_vertex(start_vertex)]
    while queue.length != 0
      current_vertex = queue.pop
      @adj_list[get_graph_vertex(current_vertex)].each do |neighbor|
        if get_vertex_color(get_graph_vertex(neighbor)) == "white"
          set_vertex_color(get_graph_vertex(neighbor), "gray")
          set_vertex_distance(get_graph_vertex(neighbor), get_vertex_distance(get_graph_vertex(current_vertex)) + 1)
          set_vertex_predecessor(get_graph_vertex(neighbor), get_graph_vertex(current_vertex))
	  queue.insert(0, get_graph_vertex(neighbor))
        end
      end
      set_vertex_color(get_graph_vertex(current_vertex), "black")
    end
  end
  
  def set_vertex_color(v, color)
    get_graph_vertex(v).color = color
  end

  def get_vertex_color(v)
    get_graph_vertex(v).color
  end
  
  def set_vertex_distance(v, distance)
    get_graph_vertex(v).distance = distance
  end

  def get_vertex_distance(v)
    get_graph_vertex(v).distance
  end
  
  def set_vertex_predecessor(v, predecessor)
    get_graph_vertex(v).predecessor = get_graph_vertex(predecessor) unless predecessor.nil?
  end

  def get_vertex_predecessor(v)
    get_graph_vertex(v).predecessor
  end
  
  private
  def get_graph_vertex(v)
    @adj_list.keys[@adj_list.keys.index(v)]
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

  def to_s
    "id: #{@id}, color: #{@color}, distance: #{@distance}, predecessor: \n\t\t #{@predecessor}"
  end
end

class Edge
  
end
