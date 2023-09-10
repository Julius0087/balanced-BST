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
    return Node.new(array[0]) if array.length == 1 
    return if array.length == 0

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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value)
    node = Node.new(value)
    traverser = @root
    loop do
      unless traverser
        break
      end

      if traverser < node
        if traverser.right
          traverser = traverser.right
        else
          traverser.right = node
          break
        end
      elsif traverser > node
        if traverser.left
          traverser = traverser.left
        else
          traverser.left = node
          break
        end
      else
        puts 'Value already exists'
      end
    end
  end

  def num_of_children(node)
    if node.left && node.right
      return 2
    elsif node.left || node.right
      # puts "one"
      return 1
    else
      # puts "zero"
      return 0
    end
  end

  def parent_of(node)
    traverser = @root
    return false if node == @root
    loop do
      if traverser.left == node
        return [traverser, :left]
      elsif traverser.right == node
        return [traverser, :right]
      end

      traverser = node.data > traverser.data ? traverser.right : traverser.left
    end
  end

  def delete(value)
    # find the node with this value
    target_node = @root
    loop do
      break if target_node.data == value

      if value > target_node.data
        target_node = target_node.right
      else
        target_node = target_node.left
      end
    end
        
    # if the node is the root
    if target_node == @root
      if num_of_children(target_node) == 0
        @root = nil
      elsif num_of_children(target_node) == 1
        if target_node.left
          @root = target_node.left
        else
          @root = target_node.right
        end
      else
        @root = delete_with_two_children(target_node)
        return
      end
    end
    
    # if the node is not a root
    parent = parent_of(target_node)
    if num_of_children(target_node) == 0
      if parent[1] == :left
        parent[0].left = nil
      else
        parent[0].right = nil
      end
    elsif num_of_children(target_node) == 1
      if parent[1] == :left
        parent[0].left = target_node.left ? target_node.left : target_node.right
      else
        parent[0].right = target_node.left ? target_node.left : target_node.right
      end
    else
      next_biggest = delete_with_two_children(target_node)

      # set the target's parent to point to the new biggest
      if parent[1] == :left
        parent[0].left = next_biggest
      else
        parent[0].right = next_biggest
      end
      puts parent[0].right.data
      # set the target's left/right to nil
      target_node.left = nil
      target_node.right = nil
    end
    
  end

  def delete_with_two_children(target_node)
    # find the next biggest
    next_biggest = target_node.right
    loop do
      if next_biggest.left
        next_biggest = next_biggest.left
      else
        break
      end
    end
    
    # if he has a child, he can only have a child on the right
    # set his parent to link to his child on the right
    next_biggest_parent = parent_of(next_biggest)
    if next_biggest.right
      next_biggest_parent[0].left = next_biggest.right
      next_biggest.right = nil
    # if not, his parent should point to nil
    else
      next_biggest_parent[0].left = nil
    end

    # set his left/right to target's left/right
    next_biggest.left = target_node.left
    next_biggest.right = target_node.right
    next_biggest
  end

end

tree = Tree.new([1, 2, 3, 4, 11, 6, 7, 8, 9, 0, 12, 5, 14])

tree.insert(10)
tree.delete(6)
tree.pretty_print
