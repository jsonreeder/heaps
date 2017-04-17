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
    child_idxs = BinaryMinHeap.child_indices(len, parent_idx)
    children = child_idxs.map { |el| array[el] }
    parent = array[parent_idx]

    while children.any? { |child| child < parent }
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
  end
end
