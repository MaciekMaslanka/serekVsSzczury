extends StaticBody2D

@export var margin = 30;
@onready var Top = $top
@onready var Bottom = $down
@onready var Left = $left
@onready var Right = $right

func _ready() -> void:
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_size_changed"))
	updateScreenSize()
	
func _on_viewport_size_changed() -> void:
	updateScreenSize()
	
func updateScreenSize():
	var ScreenSize = get_viewport_rect().size
	#góra
	Top.shape.size = Vector2(ScreenSize.x, margin)
	Top.position = Vector2(ScreenSize.x / 2.0, -margin / 2.0);
	
	#dół
	Bottom.shape.size = Vector2(ScreenSize.x, margin);
	Bottom.position = Vector2(ScreenSize.x / 2.0, ScreenSize.y + margin / 2.0)
	
	#lewo
	Left.shape.size = Vector2(margin, ScreenSize.y)
	Left.position = Vector2(-margin / 2.0, ScreenSize.y / 2.0)
	
	#prawo
	Right.shape.size = Vector2(margin, ScreenSize.y);
	Right.position = Vector2(ScreenSize.x + margin / 2.0, ScreenSize.y / 2.0);
