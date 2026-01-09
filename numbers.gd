extends PanelContainer
class_name Numbers


var hand: Array[NumberCard] = []


func _on_backend_new_shop(shop: Array[int]) -> void:
	for num: int in shop:
		var new_number_card := NumberCard.new()
		new_number_card.number = num
		add_child(new_number_card)
		hand.append(new_number_card)
	arrange_hand


func arrange_hand() -> void:
	var screen_center: float = get_window().size.x
	var half_hand: float = float(hand.size()) / 2.0
	for i: int in hand.size():
		var card: NumberCard = hand[i]
		var pos_x: float = screen_center + (float(i) - half_hand)
		card.position.x = pos_x
