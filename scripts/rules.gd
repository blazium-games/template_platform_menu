extends RefCounted

static var picked := ""

func example_ok(kind: String) -> bool:
	return kind == "android" or kind == "ios" or kind == "web"

func take_example(kind: String) -> bool:
	if not example_ok(kind):
		return false
	picked = kind
	return true

func bar_clear(top: float) -> bool:
	return top >= 48.0

func notch_clear(top: float) -> bool:
	return top >= 62.0

func page_ready(is_focused: bool) -> bool:
	return is_focused

func pass_line(kind: String) -> bool:
	if kind == "android":
		return bar_clear(48.0)
	if kind == "ios":
		return notch_clear(62.0)
	if kind == "web":
		return page_ready(true)
	return false

func reject_line(kind: String) -> bool:
	if kind == "android":
		return bar_clear(0.0)
	if kind == "ios":
		return notch_clear(0.0)
	if kind == "web":
		return page_ready(false)
	return true
