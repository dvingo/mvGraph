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
    assert @graph.vertex(1)
  end
  
  def test_add_edge
    @graph.add_vertex(Vertex.new(1))
    @graph.add_vertex(Vertex.new(2))
    @graph.add_edge(1,2)
    assert @graph.has_edge?(1,2)
  end
  
  def test_no_edge
    refute @graph.has_edge?(3,4)
  end
  
  def test_add_multiple_vertices_and_edges
    @graph.add_vertex(Vertex.new(1))
    @graph.add_vertex(Vertex.new(2))
    @graph.add_edge(2,1)
    @graph.add_vertex(Vertex.new(3))
    @graph.add_vertex(Vertex.new(4))
    @graph.add_edge(3,4)
    @graph.add_edge(1,4)
    @graph.add_edge(3,2)
    assert @graph.has_edge?(1,2)
    assert @graph.has_edge?(3,4)
    assert @graph.has_edge?(4,1)
    assert @graph.has_edge?(3,2)
  end
  
  def test_loop
    @graph.add_vertex(Vertex.new(1))
    @graph.add_edge(1,1)
    assert @graph.has_edge?(1,1)
  end
  
  def bfs_setup
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
    @bfs_graph.add_edge(1,2)
    @bfs_graph.add_edge(1,3)
    @bfs_graph.add_edge(1,4)
    @bfs_graph.add_edge(2,5)
    @bfs_graph.add_edge(5,6)
    @bfs_graph.add_edge(7,8)
    @bfs_graph.add_edge(6,7)
    @bfs_graph.add_edge(11,8)
    @bfs_graph.add_edge(9,11)
    @bfs_graph.add_edge(9,10)
    @bfs_graph.add_edge(10,5)
  end
  
  def test_bfs
    bfs_setup
    assert @bfs_graph
    bfs_search @bfs_graph
    assert_equals @bfs_graph.vertex(1).d, 0
  end
  
  def test_vertex_color
    @graph.add_vertex(Vertex.new(1))
    @graph.color_vertex(1,"white")
  end
  
end
