from collections import defaultdict

with open ("input.txt") as file:
    data = file.read().splitlines()

class Tree(object):
    def __init__(self, header, metadata, children):
        self.header = header
        self.metadata = metadata
        self.children = children

# A, which has 2 child nodes (B, C) and 3 metadata entries (1, 1, 2).
# B, which has 0 child nodes and 3 metadata entries (10, 11, 12).
# C, which has 1 child node (D) and 1 metadata entry (2).
# D, which has 0 child nodes and 1 metadata entry (99).

class Tree2(object):
    def __init__(self, datum, *args):
        self.datum = datum
        self.children = list(args)

def calculate_metadata(tree, total):
    if not tree.children:
        return total
    for child in tree.children:
        calculate_metadata(child, total + child.metadata)

def leaf_count_tree(t):
    if not t.children: # t is a leaf
        return 1
    return leaf_count_forest(t.children)
 
def leaf_count_forest(forest):
    if not forest:
        return 0
    return leaf_count_tree(forest[0]) + leaf_count_forest(forest[1:])

# def leaf_count2(t):
#     if t.children == []:
#         return 1
#     for child in t.children:
#         return sum(leaf_count2(child))

def leaf_count(t):
    if t.children == []: # if t is a leaf
        return 1
    return sum(leaf_count(child) for child in t.children)

def print_children(t):
    for child in t.children:
        print(child.metadata)


a = Tree([2, 3], [1, 1, 2], [])
b = Tree([0, 3], [10, 11, 12], [])
c = Tree([1, 1], [2], [])
d = Tree([0, 1], [99], [])
a.children = [b, c]
c.children = d

a2 = Tree2([1, 1, 2], b2, c2)
b2 = Tree2([10, 11, 12], None)
c2 = Tree2([2], d2)
d2 = Tree2([99], None)
# a2.children = [b2, c2]
# c2.children = d2
