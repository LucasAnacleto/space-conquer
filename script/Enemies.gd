extends Node2D


export(Array, PackedScene) var enemy_scenes

const ENEMY_MODEL_SIZE = Vector2(16, 16)


func get_random_enemy_scene() -> PackedScene:
	return enemy_scenes[randi() % enemy_scenes.size()]


func spawn(end_of_plarform: Vector2) -> void:
	var enemy = get_random_enemy_scene().instance()

	enemy.position = end_of_plarform
	add_child(enemy)


func _on_Cave_platform_generated(section: Dictionary, part: Dictionary, position_top: Dictionary, position_bottom: Dictionary):
	if section.index > 0 and part.size > 3:
		var x = position_top.to.x - ((position_top.to.x - position_top.from.x) / 2) - (ENEMY_MODEL_SIZE.x / 2)
		var y = rand_range(position_top.to.y + ENEMY_MODEL_SIZE.y, position_bottom.to.y - ENEMY_MODEL_SIZE.y)
		spawn(Vector2(x, y))
