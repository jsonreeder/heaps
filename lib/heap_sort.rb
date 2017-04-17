require_relative "heap"

class Array
  def heap_sort!
    sorted = []
    descending = Proc.new { |el1, el2| -1 * (el1 <=> el2) }
    heap = BinaryMinHeap.new(&descending)
    self.each { |el| heap.push(el) }

    until sorted.length == self.length
      sorted << heap.extract
    end

    sorted
  end
end
