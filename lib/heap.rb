require 'byebug'

class BinaryMinHeap
  def initialize(&prc)
    @store = []
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
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
    prc ||= Proc.new { |el1, el2| el1 < el2 }
    child_idxs = BinaryMinHeap.child_indices(len, parent_idx)
    children = child_idxs.map { |el| array[el] }
    parent = array[parent_idx]

    while children.any? { |child| prc.call(child, parent) }
      first_child_idx = child_idxs[0]
      array[parent_idx], array[first_child_idx] = array[first_child_idx], array[parent_idx]
      parent_idx = first_child_idx
      child_idxs = BinaryMinHeap.child_indices(len, parent_idx)
      children = child_idxs.map { |el| array[el] }
      parent = array[parent_idx]
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 > el2 }
    parent_idx = BinaryMinHeap.parent_index(child_idx)

    while  array[child_idx] < array[parent_idx]
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      child_idx = parent_idx
      parent_idx = child_idx.zero? ? 0 : BinaryMinHeap.parent_index(child_idx)
    end

    array
  end
end
