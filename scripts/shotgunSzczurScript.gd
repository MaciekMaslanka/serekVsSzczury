extends "res://scripts/basicSzczurScript.gd"

func shoot():
	var toPlayer = (player.global_position - global_position).normalized().angle();
	var offsets = [-0.66, -0.33, 0, 0.33, 0.66] #offsety ataku
	for offset in offsets:
		var instance = bullet.instantiate()
		instance.global_position = global_position
		instance.rotation = toPlayer + offset
		instance.bounceFromWalls = false
		instance.speed = 600
		get_tree().current_scene.add_child(instance)
		
func _on_attack_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new();
	rng.randomize();
	if bullet:
		shoot();
		$attackTimer.wait_time = rng.randf_range(2, 4)
		$attackTimer.start()
