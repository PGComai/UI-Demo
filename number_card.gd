extends PanelContainer
class_name NumberCard


var number: int = 0


@onready var label: Label = $Label


func _ready() -> void:
	label.text = str(number)
