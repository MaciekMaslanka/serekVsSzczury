extends CharacterBody2D

var direction = Vector2.ZERO
var collisionCounter: int = 0

@export var bounceFromWalls: bool = false
@export var speed: float = 300
@export var despawnDistance: float = 20

func _ready() -> void:
	direction = Vector2.RIGHT.rotated(rotation);
	direction = direction.normalized() * speed
	
	set_collision_mask_value(3, bounceFromWalls)
		
func _physics_process(delta: float) -> void:
	if bounceFromWalls:
		var targetRotation = direction.angle()
		rotation = lerp_angle(rotation, targetRotation, 0.3)
		var collision = move_and_collide(direction * delta)
		if collision:
			var normal = collision.get_normal()
			direction = direction.bounce(normal).normalized() * speed
			
			position += direction * 0.05 #odsunięcie od ściany żeby się nie jebło
	else:
		velocity = direction
		move_and_slide()
		checkForDespawn()

func checkForDespawn():
	var screen = get_viewport_rect().size
	var expanded_screen = Rect2(
		Vector2(-despawnDistance, -despawnDistance),
		screen + Vector2(despawnDistance * 2, despawnDistance * 2)
	)

	if not expanded_screen.has_point(position):
		queue_free()
		#do testów - wraca na środek mapy i obraca się w losowym kierunku
		#position = screen / 2
		#var rng = RandomNumberGenerator.new()
		#rng.randomize()
		#var angle = deg_to_rad(rng.randi_range(0, 360))
		#direction = Vector2.RIGHT.rotated(angle)
		#rotation = angle
		#collisionCounter = 0
