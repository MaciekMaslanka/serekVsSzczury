extends CharacterBody2D

@export var speed = 100;
@export var rotationSpeed = 10;
var direction = Vector2.ZERO;

func _ready() -> void:
	pass;
	
func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	
	if (Input.is_action_pressed("ui_up")):
		direction.y -= 1
		
	if (Input.is_action_pressed("ui_down")):
		direction.y += 1
		
	if (Input.is_action_pressed("ui_left")):
		direction.x -= 1
		
	if (Input.is_action_pressed("ui_right")):
		direction.x += 1
		
	direction = direction.normalized()
	velocity = direction * speed
	
	if (direction.length() > 0):
		var targetAngle = direction.angle();
		rotation = lerp_angle(rotation, targetAngle, delta * rotationSpeed)
		
	move_and_slide()
		
