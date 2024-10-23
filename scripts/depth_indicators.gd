extends Node2D

var children

func _ready():
	children = self.get_children()

func update_indicators(cur_depth, min_depth, max_depth):
	# this is hacky but min_depth will be negative
	children[0].visible = cur_depth == min_depth
	var r = max_depth * 2
	for i in range(1, children.size()):
		if cur_depth + max_depth >= r / (children.size() - 1) * i:
			children[i].visible = false
		else:
			children[i].visible = true
