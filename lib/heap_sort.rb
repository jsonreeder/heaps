require_relative "heap"

class Array
  def heap_sort!
    sorted = []
    descending = Proc.new { |el1, el2| -1 * (el1 <=> el2) }
    heap = BinaryMinHeap.new(&descending)
    self.each { |el| heap.push(el) }

    self.clear
    while heap.count > 0
      self << heap.extract
    end

    self
  end
end
