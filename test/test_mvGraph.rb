require 'minitest/autorun'
require_relative '../lib/mvGraph.rb'

class TestGraph < MiniTest::Unit::TestCase
  def setup
    @graph = Graph.new
    @vertex = Vertex.new(1)
  end

  def test_create_graph
    assert @graph
  end
  
  def test_create_vertex
    assert @vertex
  end
  
  def test_vertex_id
    @vertex.id = 1
    assert @vertex.id == 1
  end
  
  def test_add_vertex
    @graph.add_vertex(Vertex.new(1))
    assert @graph.vertex(Vertex.new(1))
  end
  
  def test_add_edge
    vertex1 = Vertex.new(1)
    @graph.add_vertex(vertex1)
    @graph.add_vertex(Vertex.new(2))
    @graph.add_edge(vertex1, Vertex.new(2))
    assert @graph.has_edge?(Vertex.new(1), Vertex.new(2))
    assert @graph.has_edge?(Vertex.new(2), Vertex.new(1))
  end
  
  def test_no_edge
    refute @graph.has_edge?(Vertex.new(3),Vertex.new(4))
  end
  
  def test_add_multiple_vertices_and_edges
    @graph.add_vertex(Vertex.new(1))
    @graph.add_vertex(Vertex.new(2))
    @graph.add_edge(Vertex.new(2),Vertex.new(1))
    @graph.add_vertex(Vertex.new(3))
    @graph.add_vertex(Vertex.new(4))
    @graph.add_edge(Vertex.new(3),Vertex.new(4))
    @graph.add_edge(Vertex.new(1),Vertex.new(4))
    @graph.add_edge(Vertex.new(3),Vertex.new(2))
    assert @graph.has_edge?(Vertex.new(1),Vertex.new(2))
    assert @graph.has_edge?(Vertex.new(3),Vertex.new(4))
    assert @graph.has_edge?(Vertex.new(4),Vertex.new(1))
    assert @graph.has_edge?(Vertex.new(3),Vertex.new(2))
  end
  
  def test_loop
    @graph.add_vertex(Vertex.new(1))
    @graph.add_edge(Vertex.new(1),Vertex.new(1))
    assert @graph.has_edge?(Vertex.new(1),Vertex.new(1)), "@graph should have the edge just added."
  end
  
  def test_vertex_equal
    assert Vertex.new(1).eql? Vertex.new(1)
    assert Vertex.new("12345").eql? Vertex.new("12345")
  end
  
  def bfs_setup_hard
    @bfs_graph = Graph.new
    @bfs_graph.add_vertex(Vertex.new(1))
    @bfs_graph.add_vertex(Vertex.new(2))
    @bfs_graph.add_vertex(Vertex.new(3))
    @bfs_graph.add_vertex(Vertex.new(4))
    @bfs_graph.add_vertex(Vertex.new(5))
    @bfs_graph.add_vertex(Vertex.new(6))
    @bfs_graph.add_vertex(Vertex.new(7))
    @bfs_graph.add_vertex(Vertex.new(8))
    @bfs_graph.add_vertex(Vertex.new(9))
    @bfs_graph.add_vertex(Vertex.new(10))
    @bfs_graph.add_vertex(Vertex.new(11))

    @bfs_graph.add_edge(Vertex.new(1),Vertex.new(2))
    @bfs_graph.add_edge(Vertex.new(1),Vertex.new(3))
    @bfs_graph.add_edge(Vertex.new(1),Vertex.new(4))
    @bfs_graph.add_edge(Vertex.new(2),Vertex.new(5))
    @bfs_graph.add_edge(Vertex.new(5),Vertex.new(6))
    @bfs_graph.add_edge(Vertex.new(6),Vertex.new(7))
    @bfs_graph.add_edge(Vertex.new(7),Vertex.new(8))
    @bfs_graph.add_edge(Vertex.new(11),Vertex.new(8))
    @bfs_graph.add_edge(Vertex.new(10),Vertex.new(5))
    @bfs_graph.add_edge(Vertex.new(10),Vertex.new(9))
    @bfs_graph.add_edge(Vertex.new(11),Vertex.new(9))
  end
  
  def bfs_setup_easy
    @bfs_graph = Graph.new
    @bfs_graph.add_vertex(Vertex.new(1))
    @bfs_graph.add_vertex(Vertex.new(2))
    @bfs_graph.add_vertex(Vertex.new(3))
    @bfs_graph.add_vertex(Vertex.new(4))
    @bfs_graph.add_edge(Vertex.new(1), Vertex.new(2))
    @bfs_graph.add_edge(Vertex.new(1), Vertex.new(3))
    @bfs_graph.add_edge(Vertex.new(1), Vertex.new(4))
  end
  
  #def test_bfs
  #  bfs_setup_hard
  #  assert @bfs_graph
  #  @bfs_graph.search(Vertex.new(1), "fifo")
  #  assert_equal "black", @bfs_graph.vertex(Vertex.new(1)).color
  #  assert_equal 0, @bfs_graph.get_vertex_distance(Vertex.new(1))
  #  assert_equal nil, @bfs_graph.get_vertex_predecessor(Vertex.new(1))
  #  assert_equal @bfs_graph.get_vertex_color(Vertex.new(11)), "black"
  #  assert @bfs_graph.get_vertex_distance(Vertex.new(11)) == 5
  #  assert @bfs_graph.get_vertex_predecessor(Vertex.new(11)) == Vertex.new(9)
  #end

  #def test_shortest_path
  #  bfs_setup_hard
  #  assert @bfs_graph
  #  @bfs_graph.search(Vertex.new(1), "fifo")
  #  path = @bfs_graph.shortest_path(Vertex.new(1), Vertex.new(11))
  #  assert path[0] == Vertex.new(1) 
  #  assert path[1] == Vertex.new(2) 
  #  assert path[2] == Vertex.new(5) 
  #  assert path[3] == Vertex.new(10) 
  #  assert path[4] == Vertex.new(9) 
  #  assert path[5] == Vertex.new(11) 
  #end

  #def test_no_shortest_path
  #  bfs_setup_hard
  #  assert @bfs_graph
    #@bfs_graph.add_vertex(Vertex.new(20))
    #@bfs_graph.search(Vertex.new(1), "fifo")
    #path = @bfs_graph.shortest_path(Vertex.new(1), Vertex.new(20))
    #assert path == "No path."
  #end
  
  def test_get_all_vertices
    bfs_setup_easy
    @bfs_graph.each { |vertex| assert vertex }
  end

  def test_neighbors_of
    bfs_setup_easy
    neighbors = @bfs_graph.neighbors_of(Vertex.new(1))
    assert_equal 2, neighbors[0].id, "First neighbor should be 2."
    assert_equal 3, neighbors[1].id, "Second neighbor should be 3."
    assert_equal 4, neighbors[2].id, "Third neighbor should be 4."
  end

  def test_vertex_color
    v = Vertex.new(1)
    v.color = "gray"
    @graph.add_vertex(v)
    assert_equal "gray", @graph.vertex(Vertex.new(1)).color 
  end
  
  def test_vertex_distance
    v = Vertex.new(1)
    v.distance = 100
    @graph.add_vertex(v)
    assert_equal 100, @graph.vertex(Vertex.new(1)).distance 
  end
  
  def test_vertex_predecessor
    @graph.add_vertex(Vertex.new(1))
    @graph.vertex(Vertex.new(1)).predecessor = "5"
    assert_equal "5", @graph.vertex(Vertex.new(1)).predecessor
  end
  
  #def test_dfs
  #  bfs_setup_hard
  #  assert @bfs_graph
  #  @bfs_graph.search(Vertex.new(1), "lifo")
  #  assert_equal "black", @bfs_graph.vertex(Vertex.new(1)).color
  #  assert_equal 0, @bfs_graph.vertex(Vertex.new(1)).distance
  #  assert_equal nil, @bfs_graph.vertex(Vertex.new(1)).predecessor
  #  assert_equal @bfs_graph.vertex(Vertex.new(11)).color, "black"
  #  assert @bfs_graph.vertex(Vertex.new(11)).distance == 5
  #  assert @bfs_graph.vertex(Vertex.new(11)).predecessor == Vertex.new(9)
  #end
end
