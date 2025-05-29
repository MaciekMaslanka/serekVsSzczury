extends CharacterBody2D

@export var bullet: PackedScene = preload("res://scenes/bullet_szczur.tscn")
@onready var leftEye = $Sprite2D/LeftEye
@onready var rightEye = $Sprite2D/RightEye
@export var maxEyeOffset: float = 5;
@export var eyeFollowingSpeed: float = 0.5;
var leftBasePos = Vector2.ZERO
var rightBasePos = Vector2.ZERO

@export var speed = 175;
@export var rotationFromWalls = 0.2;
@export var rotationToPlayer:float = 0.15
@onready var player = get_node("/root/Node2D/Player") #pobranie nodea gracza

var direction = Vector2.ZERO

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	direction = Vector2.RIGHT.rotated(deg_to_rad(rng.randi_range(0, 360)))
	
	leftBasePos = leftEye.position
	rightBasePos = rightEye.position
	
func _physics_process(delta: float) -> void:
	setRotationToPlayer(delta)
	direction = direction.normalized() * speed
	setRotation()
	updateEyes()
	
	var collision = move_and_collide(direction * delta)
	if collision:
		var normal = collision.get_normal();
		direction = direction.bounce(normal)
	
func setRotation(): #ustawia poprawną rotację + zmienia kierunek delikatnie w stronę gracza
	var targetRotation = direction.angle()
	rotation = lerp_angle(rotation, targetRotation, rotationFromWalls)
	
func setRotationToPlayer(delta):
	var vectorToPlayer = (player.global_position - global_position).normalized() #oblicza wektor do gracza (trzeba było słuchać na matmie)
	var angleToPlayer = vectorToPlayer.angle()
	var currentAngle = direction.angle()
	var newAngle = lerp_angle(currentAngle, angleToPlayer, rotationToPlayer * delta);
	direction = Vector2.RIGHT.rotated(newAngle)
	
func updateEyes():
	var toPlayer = (player.global_position - global_position).normalized()
	toPlayer = to_local(global_position + toPlayer)
	var eyeOffset = toPlayer * maxEyeOffset
	
	leftEye.position = leftEye.position.lerp(leftBasePos + eyeOffset, eyeFollowingSpeed)
	rightEye.position = rightEye.position.lerp(rightBasePos + eyeOffset, eyeFollowingSpeed)
