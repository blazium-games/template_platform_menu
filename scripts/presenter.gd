extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()
var index := 0

func kinds() -> PackedStringArray:
	return PackedStringArray(["android", "ios", "web"])

func _ready() -> void:
	var lens: Camera2D = get_node("SheetLens")
	lens.make_current()
	_paint()

func _unhandled_input(event: InputEvent) -> void:
	var list: PackedStringArray = kinds()
	if event.is_action_pressed("stride_south"):
		index = (index + 1) % list.size()
		_paint()
	elif event.is_action_pressed("stride_north"):
		index = (index + list.size() - 1) % list.size()
		_paint()
	elif event.is_action_pressed("primary") and rules.take_example(list[index]):
		_go("res://scenes/board.tscn")

func _paint() -> void:
	var names: PackedStringArray = PackedStringArray(["AndroidRow", "IosRow", "WebRow"])
	for i in names.size():
		var row: ColorRect = get_node(names[i]) as ColorRect
		if i == index:
			row.color = Color(0.25, 0.55, 0.4, 1)
		else:
			row.color = Color(0.18, 0.2, 0.24, 1)

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
