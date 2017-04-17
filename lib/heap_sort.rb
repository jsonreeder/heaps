require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new { |el1, el2| -1 * (el1 <=> el2) }
    heap.push(self.pop) until self.length.zero?
    self << heap.extract while heap.count > 0
    self
  end
end
