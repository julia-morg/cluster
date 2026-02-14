extends Node
class_name PlayerData

signal coins_changed
signal name_changed
signal level_changed

var coins: int
var player_name: String
var level: int

func get_coins() -> int:
	return coins
	
func set_coins(new_value: int) -> int :
	coins = new_value
	coins_changed.emit()
	return coins
	
func add_coins(sum:int)-> int :
	coins+= sum
	coins_changed.emit()
	return coins

func can_consume_coins(sub:int) -> bool:
	return coins >= sub
	
func consume_coins(sub:int)-> int :
	if coins < sub:
		return coins
	coins_changed.emit()
	coins-= sub
	return coins

func get_player_name() -> String:
	return player_name
		
func set_player_name(new_name: String) -> String:
	player_name = new_name
	name_changed.emit()
	return player_name
	
func get_level() -> int:
	return level
		
func set_level(new_level: int) -> int:
	if new_level <= level:
		return level
	level = new_level
	level_changed.emit()
	return level	
