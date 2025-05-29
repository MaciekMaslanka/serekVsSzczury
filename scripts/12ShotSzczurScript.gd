extends "res://scripts/basicSzczurScript.gd"

func shoot(rng: RandomNumberGenerator):
	var toPlayer = (player.global_position - global_position).normalized().angle()
	var bulletInstance = bullet.instantiate() 
	bulletInstance.global_position = global_position
	bulletInstance.rotation = toPlayer + rng.randf_range(-0.25, 0.25)
	bulletInstance.bounceFromWalls = false
	get_tree().current_scene.add_child(bulletInstance)

func _on_attack_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if bullet:
		for i in range(12):
			shoot(rng);
			await get_tree().create_timer(0.15).timeout
		$attackTimer.wait_time = rng.randf_range(0.75, 1.25)
		$attackTimer.start()
