extends Node


signal div_zero
signal new_shop(shop: Array[int])
signal score_changed(old_score: float, new_score: float)


const DEFAULT_SHOP_SIZE: int = 5
const MAX_NUMBER: float = 10.0
const MAX_ITEMS: int = 10


var score: float = 0.0:
	set(value):
		if score != value:
			score_changed.emit(score, value)
			score = value
var items: Array[Item] = []
var number_shop: Array[int] = []
var goal: int = 99


func _ready() -> void:
	roll_number_shop()
	for i in 5:
		items.append(draw_item())


func draw_item() -> Item:
	var new_item := Item.new()
	new_item.effect = Item.ItemEffect.keys().pick_random()
	return new_item


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
