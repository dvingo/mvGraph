require 'minitest/autorun'
require_relative '../lib/mvQueue.rb'

class TestQueue < MiniTest::Unit::TestCase
  def setup
    @queue = Queue.new
  end

  def iterate_setup
    @queue = Queue.new
    @queue.enqueue(1)
    @queue.enqueue(2)
    @queue.enqueue(3)
    @queue.enqueue(4)
    @queue.enqueue(5)
  end

  def test_enqueue_dequeue
    @queue.enqueue("x")
    assert_equal @queue.dequeue, "x"
  end

  def test_queue_accessor_is_private
    refute @queue.respond_to? :queue
  end

  def test_iterate_queue
    iterate_setup
    assert_equal 1, @queue.dequeue
    assert_equal 2, @queue.dequeue
    assert_equal 3, @queue.dequeue
    assert_equal 4, @queue.dequeue
    assert_equal 5, @queue.dequeue
    assert @queue.empty?
  end
end