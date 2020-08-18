extends Node2D


export(Array, String, FILE, "*.tscn") var obstacle_file_paths
var obstacle_types = {}
var last_obstacle_type_name: String
var next_obstacles = []

func _ready():
	randomize()
	
	for obstacle_file_path in obstacle_file_paths:
		var obstacle_name = obstacle_file_path.get_file().get_basename()
		var obstacle_class = load(obstacle_file_path)

		obstacle_types[obstacle_name] = obstacle_class 


func _on_Timer_timeout():		
	var next_obstacle_type = get_next_obstacle_type()
	
	match next_obstacle_type.name:
		"boss_one":
			var one = next_obstacle_type.scene.instance()
			one.position = position
			
			next_obstacles.clear()
			next_obstacles.append(one)
			
		"boss_two":
			var two = next_obstacle_type.scene.instance()
			
			two.position = position
			
			next_obstacles.clear()
			next_obstacles.append(two)
			
		"boss_three":
			var three = next_obstacle_type.scene.instance()
			
			three.position = position
			
			next_obstacles.clear()
			next_obstacles.append(three)
			
		"boss_four":
			var four = next_obstacle_type.scene.instance()
			
			four.position = position
			
			next_obstacles.clear()
			next_obstacles.append(four)
			
		"boss_five":
			var five = next_obstacle_type.scene.instance()
			
			five.position = position
			
			next_obstacles.clear()
			next_obstacles.append(five)
			
		"boss_six":
			var six = next_obstacle_type.scene.instance()
			
			six.position = position
			
			next_obstacles.clear()
			next_obstacles.append(six)
			
	for next_obstacle in next_obstacles:
		 owner.add_child(next_obstacle)
		
		
	
	
func get_next_obstacle_type() -> Dictionary:
	var obstacle_type_names = obstacle_types.keys()
	var next_obstacle_type_name = last_obstacle_type_name
	
	while next_obstacle_type_name == last_obstacle_type_name:
		next_obstacle_type_name = obstacle_type_names[randi() % obstacle_type_names.size()]

	last_obstacle_type_name = next_obstacle_type_name

	return {
		"name": next_obstacle_type_name,
		"scene": obstacle_types[next_obstacle_type_name],
	}
