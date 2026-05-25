extends Node

#Command Points
@export var max_cp = 6
var current_cp = 6

#turn tracking
var current_turn = 1
var is_player_turn = true

func _ready():
	print("Turn " + str(current_turn) + " - Player CP: " + str(current_cp))

func spend_cp(amount:int) -> bool:
#if have enough CP sub it and return true
	if current_cp >= amount:
		current_cp -= amount
		print("CP spent. Remaining: " + str(current_cp))
		return true
#if not enough, return false
	else:
		print("Not enough CP")
		return false

#refills CP back to max, increase turn, flip to enemy turn
func end_turn():
	current_cp = max_cp
	current_turn += 1
	is_player_turn = false
	print("Turn " + str(current_turn) + " - Enemy Turn")
