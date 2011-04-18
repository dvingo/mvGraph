class Queue < Array


  def initialize(type)
    #super()
    @type = type
    @func_map = {"fi" => Proc.new{|item| self.insert(0, item) }, "li" => Proc.new{|item| self << item}, "fo" => Proc.new{self.pop}, "lo" => Proc.new{}}
  end
  
  def enqueue(item)
    @func_map[@type[0..1]].call(item)
  end

  def dequeue
    @func_map[@type[2..3]].call()
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
