extends "res://scripts/basicSzczurScript.gd"

func shoot():
	var toPlayer = (player.global_position - global_position).normalized().angle()
	var bulletInstance = bullet.instantiate() 
	bulletInstance.global_position = global_position
	bulletInstance.rotation = toPlayer
	bulletInstance.speed = 700
	bulletInstance.bounceFromWalls = false
	get_tree().current_scene.add_child(bulletInstance)

func _on_attack_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	if bullet:
		shoot();
		await get_tree().create_timer(0.15).timeout
		shoot()
		$attackTimer.wait_time = rng.randf_range(0.75, 1.25)
		$attackTimer.start()
