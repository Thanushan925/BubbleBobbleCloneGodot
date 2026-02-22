extends CharacterBody2D


const SPEED = 210.0
var direction : float = -1.0

var is_captured = false

var is_raging: bool = false
@export var rage_speed_multiplier: float = 2.0
@export var rage_delay: float = 3.0

@onready var sprite : Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	if is_captured or get_tree().current_scene.game_over_active:
		return

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var current_speed = SPEED
	if is_raging:
		current_speed *= rage_speed_multiplier
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	velocity.x = direction * current_speed
	sprite.flip_h = direction < 0

	move_and_slide()
	
	if global_position.y > 700:
		global_position.y = -10
	
	if is_on_wall():
		direction *= -1.0
