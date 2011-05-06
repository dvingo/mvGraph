require_relative 'mvQueue.rb'
class Graph
  include Enumerable
  def each
    @adj_matrix.keys.each do |vertex|
      yield vertex
    end
  end

  def neighbors_of(vertex)
    @adj_matrix[vertex].select { |v| has_edge?(vertex, v) }.keys
  end
  
  def initialize
    @adj_matrix = Hash.new 
  end
  
  def add_vertex(v)
    @adj_matrix[v] = Hash.new
  end
  
  def vertex(v)
    @adj_matrix.find { |vertex| vertex[0] == v }[0]
  end
  
  def add_edge(v1, v2)
    @adj_matrix[v1][v2] = 1
    @adj_matrix[v2][v1] = 1
  end

  def update_vertex(v)
    @adj_matrix[v] = @adj_matrix[vertex(v)]
  end
  
  def has_edge?(v1, v2)
    unless @adj_matrix[v1].nil? or @adj_matrix[v1][v2].nil?
      @adj_matrix[v1][v2] == 1
    end
  end
  
  #
  # queue_type is one of fifo or lifo
  #
  # Look into passing a hash of arguments
  def search(start_vertex, queue_type, neighbor_function=nil, goal_state=nil, search_depth=nil)
    set_vertex_color(start_vertex, "gray")
    set_vertex_distance(start_vertex, 0)
    queue = Queue.new(queue_type)
    queue.enqueue(get_graph_vertex(start_vertex))
    goal_not_reached = true
    count = 0
    return_goal_state = nil
    while queue.length != 0 and goal_not_reached
      current_vertex = queue.dequeue
      count += 1
      # Full BFS or DFS with no goal state
      if neighbor_function.nil? and search_depth.nil? and goal_state.nil?
        neighbors_of(current_vertex).each do |neighbor|
	  if neighbor.color == "white"
	    set_vertex_color(get_graph_vertex(neighbor), "gray")
	    set_vertex_distance(get_graph_vertex(neighbor), get_vertex_distance(get_graph_vertex(current_vertex)) + 1)
	    set_vertex_predecessor(get_graph_vertex(neighbor), get_graph_vertex(current_vertex))
	    queue.enqueue(get_graph_vertex(neighbor))
	  end
	end
	set_vertex_color(get_graph_vertex(current_vertex), "black")
      # Search for goal_state with no distance limit
      elsif !neighbor_function.nil? and !goal_state.nil? and search_depth.nil?
	neighbors = current_vertex.send(neighbor_function, goal_state)
	neighbors.each do |neighbor|
	  unless self.include? neighbor
	    self.add_vertex(neighbor)
	    self.add_edge(current_vertex, neighbor)
	    
	    if neighbor == goal_state
              neighbor.color = "gray"
	      neighbor.distance = current_vertex.distance + 1
	      neighbor.predecessor = current_vertex
	      return_goal_state = neighbor
	      goal_not_reached = false
	      break
	    end
	    if neighbor.color == "white"
	      neighbor.color = "gray"
	      neighbor.distance = current_vertex.distance + 1
	      neighbor.predecessor = current_vertex
	      queue.enqueue(neighbor)
	    end
	    current_vertex.color = "black"
	  end
	end
      # Random walk to a given distance and no goal state
      elsif !neighbor_function.nil? and goal_state.nil? and !search_depth.nil?
	neighbors = current_vertex.send(neighbor_function)
	neighbors.each do |neighbor|
	  unless self.include? neighbor
	    add_vertex(neighbor)
	    add_edge(current_vertex, neighbor)
	    if count == search_depth
	      return_goal_state = neighbor
	      goal_not_reached = false
	      break
	    end
	    if neighbor.color == "white"
	      neighbor.color = "gray"
	      neighbor.distance = current_vertex.distance + 1
	      neighbor.predecessor = current_vertex
	      queue.enqueue(neighbor)
	    end
	    current_vertex.color = "black"
	  end
	end
      else
	# Other possible prototypes
      end	
    end
    return return_goal_state, count
  end

  # Performs depth-first search to the given depth, starting at the vertex start_state.
  def walk_n_steps(start_state, neighbor_function, depth)
    search(start_state, "lifo", neighbor_function, nil, depth)
  end
 
  # 
  # Precondition: BFS has been run on the graph
  #
  def shortest_path(start_vertex, end_vertex)
    @ret_array ||= []
    predecessor = end_vertex.predecessor
    if start_vertex == end_vertex
      @ret_array << start_vertex
    elsif predecessor.nil?
      "No path."
    else
      shortest_path(start_vertex, predecessor)
      @ret_array << end_vertex
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
    @adj_matrix.find { |vertex| vertex[0] == v }[0]
  end
end

class Vertex
  attr_accessor :id, :color, :distance, :predecessor
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
