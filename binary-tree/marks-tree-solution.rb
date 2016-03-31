class Node
  attr_accessor :left, :right, :value

  def initialize(left, right, value)
    self.left = left
    self.right = right
    self.value = value
  end

  def traverse
    collection = [value]
    collection << left.traverse if left
    collection << right.traverse if right
    return collection
  end

  def to_a
    traverse.flatten
  end

  def print_tree
    to_a.each{|node| puts node }
  end

end

root = Node.new(nil,nil,1)
node_2 = Node.new(nil, nil, 2)
node_3 = Node.new(nil, nil, 3)
node_4 = Node.new(nil, nil, 4)

root.left = node_2
root.right = node_3
node_2.right = node_4

root.print_tree
p root.to_a
