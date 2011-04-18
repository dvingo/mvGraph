class Queue < Array
  include Enumerable

  def each
    0..@queue.size().each do |i|
       yield @queue.pop
    end
  end

  def initialize
    @queue = [] 
  end

  def enqueue(item)
    queue.insert(0, item) 
  end

  def dequeue
    queue.pop
  end
  private 
  attr_accessor :queue
end
