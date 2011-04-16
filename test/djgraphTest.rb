require 'minitest/autorun'
require_relative 'djgraph.rb'

class TestGraph < MiniTest::Unit::TestCase
  def setup
    @graph = DJGraph.new
    @vertex = DJVertex.new(1)
    @edge = DJEdge.new
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
    @graph.add_vertex(DJVertex.new(1))
    assert @graph.vertex(1)
  end
  
  def test_add_edge
    @graph.add_vertex(DJVertex.new(1))
    @graph.add_vertex(DJVertex.new(2))
    @graph.add_edge(1,2)
    assert @graph.edge?(1,2)
  end
  
  def test_no_edge
    refute @graph.edge?(3,4)
  end
end
