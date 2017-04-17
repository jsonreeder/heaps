require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @store = []
  end

  def count
    @store.count
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    extracted = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0, count, &prc)
    extracted
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    @store = BinaryMinHeap.heapify_up(@store, count - 1, count, &prc)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    children = [parent_index * 2 + 1, parent_index * 2 + 2]
    children.select { |el| el < len }
  end

  def self.parent_index(child_index)
    raise 'root has no parent' unless child_index > 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    return array if len <= 1
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    child_idxs = BinaryMinHeap.child_indices(len, parent_idx)
    children = child_idxs.map { |el| array[el] }
    parent = array[parent_idx]
    # Find which child
    child_idx = child_idxs.first
    child_idx = child_idxs.last if child_idxs.length > 1 && prc.call(children[0], children[1]) > 0
    child = array[child_idx]
    
    # Make the switch
    while child && prc.call(child, parent) < 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      parent_idx = child_idx
      child_idxs = BinaryMinHeap.child_indices(len, parent_idx)
      children = child_idxs.map { |el| array[el] }
      child_idx = child_idxs.first
      child_idx = child_idxs.last if child_idxs.length == 2 && prc.call(children[0], children[1]) > 0
      if child_idx
        child = array[child_idx]
      else
        child = nil
      end
      parent = array[parent_idx] if parent_idx
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if len <= 1
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    parent_idx = BinaryMinHeap.parent_index(child_idx)


    while prc.call(array[child_idx], array[parent_idx]) < 0
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
      parent_idx = child_idx.zero? ? 0 : BinaryMinHeap.parent_index(child_idx)
    end

    array
  end
end
