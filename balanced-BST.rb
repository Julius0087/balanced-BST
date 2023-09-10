class Node
  include Comparable
  attr :data
  def <=>(other)
    data <=> other.data
  end

  attr_accessor :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree

  attr_reader :root
  def initialize(array)
    # @array = array
    @root = build_tree(array)
  end

  def build_tree(array)
    # base case
    return Node.new(array[0]) if array.length <= 1 

    # sort and remove duplicates
    array.uniq!
    array.sort!
    
    # split the array into left, root and right
    root_index = (array.length / 2).floor
    left = array.slice(0..root_index - 1)
    right = array.slice(root_index + 1..-1)
    root = array[root_index]
    
    # build the node and the two sides of the tree
    root_node = Node.new(root)
    root_node.left = build_tree(left)
    root_node.right = build_tree(right)
    
    root_node
  end

  def testing(node = @root)
    puts node.right
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 2, 3, 4, 11, 6, 7, 8, 9])
tree.pretty_print
