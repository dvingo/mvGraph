require_relative 'mvQueue.rb'
class Graph
  include Enumerable
  def each
    @adj_matrix.keys.each do |vertex|
      yield vertex
    end
  end
  
  def initialize
    @adj_matrix = Hash.new 
  end
  
  def add_vertex(v)
    @adj_matrix[v] = Hash.new
  end
  
  def vertex(v)
    @adj_matrix.each { |v| puts "v in vertex: #{v[0]}" }
    #@adj_matrix.find { |vertex| vertex[0] == v }
  end
  
  def add_edge(v1, v2)
    @adj_matrix[v1][v2] = 1
    @adj_matrix[v2][v1] = 1
  end
  
  def has_edge?(v1, v2)
    unless @adj_matrix[v1][v2].nil?
      @adj_matrix[v1][v2] == 1
    end
  end
  
  #
  # queue_type is one of fifo or lifo
  #
  # Look into passing a hash of arguments
  def search(start_vertex, queue_type, neighbor_function=nil, goal_state=nil, search_depth=nil)
    start_vertex.color = "gray"
    start_vertex.distance = 0
    queue = Queue.new(queue_type)
    queue.enqueue(start_vertex)
    goal_not_reached = true
    count = 0
    return_goal_state = nil
    while queue.length != 0 and goal_not_reached
      current_vertex = queue.dequeue
      count += 1
      # Full BFS or DFS with no goal state
      if neighbor_function.nil? and search_depth.nil? and goal_state.nil?
	@adj_matrix[current_vertex].each do |neighbor|
	  if neighbor.color == "white"
	    neighbor.color = "gray"
	    neighbor.distance =  current_vertex.distance + 1
	    neighbor.predecessor = current_vertex
	    queue.enqueue(neighbor)
	  end
	end
	current_vertex.color = "black"
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
