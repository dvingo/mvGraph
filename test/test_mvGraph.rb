require 'minitest/autorun'
require_relative '../lib/mvGraph.rb'

class TestGraph < MiniTest::Unit::TestCase
  def setup
    @graph = Graph.new
    @vertex = Vertex.new(1)
    @edge = Edge.new
  end

  def test_create_graph
    assert @graph
  end
  
  def test_create_vertex
    assert @vertex
  end
  
  def test_create_edge
    assert @edge
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
    assert @graph.has_edge?(Vertex.new(1),Vertex.new(2))
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
    assert @graph.has_edge?(Vertex.new(1),Vertex.new(1))
  end
  
  def test_vertex_equal
    assert Vertex.new(1).eql? Vertex.new(1)
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
    @bfs_graph.add_edge(Vertex.new(1),Vertex.new(2))
    @bfs_graph.add_edge(Vertex.new(1),Vertex.new(3))
    @bfs_graph.add_edge(Vertex.new(1),Vertex.new(4))
  end
  
  def test_bfs
    bfs_setup_hard
    assert @bfs_graph
    @bfs_graph.bfs(Vertex.new(1))
    assert_equal "black", @bfs_graph.get_vertex_color(Vertex.new(1))
    assert_equal 0, @bfs_graph.get_vertex_distance(Vertex.new(1))
    assert_equal nil, @bfs_graph.get_vertex_predecessor(Vertex.new(1))
    
    @bfs_graph.each {|vertex| p vertex}
    
    #assert_equal @bfs_graph.get_vertex_color(Vertex.new(11)), "black"
    #assert @bfs_graph.get_vertex_distance(Vertex.new(11)) == 6 or @bfs_graph.get_vertex_distance(Vertex.new(11)) == 5
    #assert @bfs_graph.get_vertex_predecessor(Vertex.new(11)) == Vertex.new(8) or @bfs_graph.get_vertex_predecessor(Vertex.new(11)) == Vertex.new(9)
    
  end
  
  def test_get_all_vertices
    bfs_setup_easy
    @bfs_graph.each {|vertex| assert vertex}
  end
  
  def test_vertex_color
    @graph.add_vertex(Vertex.new(1))
    @graph.set_vertex_color(Vertex.new(1),"white")
    assert_equal @graph.get_vertex_color(Vertex.new(1)), "white"
  end
  
  def test_vertex_distance
    @graph.add_vertex(Vertex.new(1))
    @graph.set_vertex_distance(Vertex.new(1), 0)
    assert_equal @graph.get_vertex_distance(Vertex.new(1)), 0
  end
  
  def test_vertex_predecessor
    @graph.add_vertex(Vertex.new(1))
    @graph.set_vertex_predecessor(Vertex.new(1), nil)
    assert_equal @graph.get_vertex_predecessor(Vertex.new(1)), nil
  end
  
end
