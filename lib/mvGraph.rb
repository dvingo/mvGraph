require_relative 'mvQueue.rb'
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
    while queue.length != 0 and goal_not_reached and count != search_depth
      current_vertex = queue.dequeue
      count += 1
      if neighbor_function.nil?
	@adj_list[get_graph_vertex(current_vertex)].each do |neighbor|
	  if get_vertex_color(get_graph_vertex(neighbor)) == "white"
	    set_vertex_color(get_graph_vertex(neighbor), "gray")
	    set_vertex_distance(get_graph_vertex(neighbor), get_vertex_distance(get_graph_vertex(current_vertex)) + 1)
	    set_vertex_predecessor(get_graph_vertex(neighbor), get_graph_vertex(current_vertex))
	    queue.enqueue(get_graph_vertex(neighbor))
	  end
	end
	set_vertex_color(get_graph_vertex(current_vertex), "black")
      elsif !goal_state.nil?
	neighbors = get_graph_vertex(current_vertex).send(neighbor_function, goal_state)
	neighbors.each do |neighbor|
	  unless self.include? neighbor
	    add_vertex neighbor 
	    add_edge current_vertex, neighbor
	    
	    if neighbor == goal_state
	      return_goal_state = neighbor
	      puts "goal: #{neighbor}"
	      goal_not_reached = false
	      break
	    end
	    if get_vertex_color(get_graph_vertex(neighbor)) == "white"
	      set_vertex_color(get_graph_vertex(neighbor), "gray")
	      set_vertex_distance(get_graph_vertex(neighbor), get_vertex_distance(get_graph_vertex(current_vertex)) + 1)
	      set_vertex_predecessor(get_graph_vertex(neighbor), get_graph_vertex(current_vertex))
	      queue.enqueue(get_graph_vertex(neighbor))
	    end
	    set_vertex_color(get_graph_vertex(current_vertex), "black")
	  end
	end
      elsif !search_depth.nil?
	neighbors = get_graph_vertex(current_vertex).send(neighbor_function, goal_state)
	neighbors.each do |neighbor|
	  unless self.include? neighbor
	    add_vertex neighbor 
	    add_edge current_vertex, neighbor
	    
	    if count == search_depth
	      return_goal_state = neighbor
	      puts "Solution at #{distance}: #{neighbor}"
	      goal_not_reached = false
	      break
	    end
	    if get_vertex_color(get_graph_vertex(neighbor)) == "white"
	      set_vertex_color(get_graph_vertex(neighbor), "gray")
	      set_vertex_distance(get_graph_vertex(neighbor), get_vertex_distance(get_graph_vertex(current_vertex)) + 1)
	      set_vertex_predecessor(get_graph_vertex(neighbor), get_graph_vertex(current_vertex))
	      queue.enqueue(get_graph_vertex(neighbor))
	    end
	    set_vertex_color(get_graph_vertex(current_vertex), "black")
	  end
	end

      else
	# Other possible prototypes
      end	
    end
    return return_goal_state, count
  end
 
  # 
  # Precondition: BFS has been run on the graph
  #
  def shortest_path(start_vertex, end_vertex)
    @ret_array ||= []
    predecessor = get_vertex_predecessor(get_graph_vertex(end_vertex))
    if start_vertex == end_vertex
      @ret_array << get_graph_vertex(start_vertex)
    elsif predecessor.nil?
      "No path."
    else
      shortest_path(get_graph_vertex(start_vertex), predecessor)
      @ret_array << get_graph_vertex(end_vertex)
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
