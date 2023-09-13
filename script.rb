require './balanced-BST.rb'

tree = Tree.new(Array.new(15) { rand(1..100) })

puts "Tree before"
tree.pretty_print

p "Level order: #{tree.level_order}"
p "Level order (recursive): #{tree.level_order_recursive}"
p "Pre order: #{tree.preorder}"
p "Post order: #{tree.postorder}"
p "In order: #{tree.inorder}"

tree.insert(105)
tree.insert(200)
tree.insert(122)
tree.insert(144)
tree.insert(178)

p tree.balanced?

tree.rebalance
p tree.balanced?

puts "Tree after"
tree.pretty_print
p "Level order: #{tree.level_order}"
p "Level order (recursive): #{tree.level_order_recursive}"
p "Pre order: #{tree.preorder}"
p "Post order: #{tree.postorder}"
p "In order: #{tree.inorder}"
