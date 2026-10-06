extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_example_ok() -> void:
	var rules = Rules.new()
	assert_false(rules.example_ok("desktop"), "unknown kind")
	assert_false(rules.take_example("desktop"), "unknown stays closed")
	assert_true(rules.example_ok("android"), "android")
	assert_true(rules.example_ok("ios"), "ios")
	assert_true(rules.example_ok("web"), "web")

func test_showcase() -> void:
	var rules = Rules.new()
	assert_true(rules.take_example("android"), "pick android")
	assert_true(rules.pass_line("android"), "status bar kept")
	assert_false(rules.reject_line("android"), "status bar rejected")
	assert_true(rules.pass_line("ios"), "notch kept")
	assert_false(rules.reject_line("ios"), "notch rejected")
	assert_true(rules.pass_line("web"), "focus kept")
	assert_false(rules.reject_line("web"), "focus rejected")
	assert_false(rules.pass_line("desktop"), "unknown pass")
	assert_true(load("res://scenes/board.tscn") != null, "board loads")
