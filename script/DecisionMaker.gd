extends Node


static func should_draw_gaps(_width: int, index: int, _total: int) -> bool:
	match index:
		-1, 0:
			return false
		_:
			return true
