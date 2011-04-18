class Queue < Array

  def enqueue(item)
    self.insert(0, item) 
  end

  def dequeue
    self.pop
  end
  
  def to_s
    the_string = ""
    self.each do |item|
      the_string += item.to_s
      the_string += ","
    end
    the_string[0..the_string.size()-2]
  end

end
