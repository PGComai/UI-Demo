extends Node


signal div_zero
signal new_shop(shop: Array[int])


const DEFAULT_SHOP_SIZE: int = 5
const MAX_NUMBER: float = 10.0


var score: float = 0
var items: Dictionary[int, Item] = {}
var number_shop: Array[int] = []
var goal: int = 99


func _ready() -> void:
	roll_number_shop()


func draw_item() -> void:
	var new_item := Item.new()
	new_item.effect = Item.ItemEffect.keys().pick_random()


func roll_number_shop() -> void:
	number_shop = []
	for i in DEFAULT_SHOP_SIZE:
		number_shop.append(randi_range(-MAX_NUMBER, MAX_NUMBER))
	new_shop.emit(number_shop)


func affect_score(item: Item, number: int) -> float:
	var num_float: float = float(number)
	match item.effect:
		item.ItemEffect.ADD:
			return score + num_float
		item.ItemEffect.SUBTRACT:
			return score - num_float
		item.ItemEffect.MULTIPLY:
			return score * num_float
		item.ItemEffect.DIVIDE:
			if number == 0:
				div_zero.emit()
			else:
				return score / num_float
		item.ItemEffect.POWER:
			return pow(score, num_float)
		item.ItemEffect.MOD:
			if number == 0:
				div_zero.emit()
			else:
				return fmod(score, num_float)
	return score
