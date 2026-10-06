extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

func _ready() -> void:
	var lens: Camera2D = get_node("SheetLens")
	lens.make_current()
	var kind: String = Rules.picked
	var caption: Label = get_node("Caption")
	var kept: Label = get_node("PassLine")
	var denied: Label = get_node("RejectLine")
	if not rules.example_ok(kind):
		caption.text = "Unknown example"
		kept.text = ""
		denied.text = ""
		return
	caption.text = kind
	kept.text = "kept" if rules.pass_line(kind) else "missing"
	denied.text = "rejected" if not rules.reject_line(kind) else "missing"
