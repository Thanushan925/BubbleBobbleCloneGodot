extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

@export var stand_texture : Texture2D
@export var run_texture : Texture2D

@onready var sprite : Sprite2D = $Sprite2D

@export var max_lives : int = 5
var lives : int
var invincible : bool = false

@export var bubble_scene : PackedScene
var facing : float = 1.0


func _physics_process(delta: float) -> void:
	if get_tree().current_scene.game_over_active:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")

	if direction:
		velocity.x = direction * SPEED
		facing = direction
		
		sprite.texture = run_texture
		sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.texture = stand_texture

	
	if Input.is_action_just_pressed("fire"):
		shoot_bubble()
	
	move_and_slide()
	
	# Vertical wrap
	if global_position.y > 700:
		global_position.y = -10
		
			
func take_damage():
	lives -= 1
	get_tree().current_scene.hud.update_lives(lives)
	
	if lives <= 0:
		get_tree().current_scene.game_over()
		return

	invincible = true
	velocity.y = -200
	
	await get_tree().create_timer(1.0).timeout
	invincible = false

func shoot_bubble():
	var bubble = bubble_scene.instantiate()
	bubble.dir = facing
	
	bubble.position = position + Vector2(30 * facing, -10)
	get_parent().add_child(bubble)


func _ready():
	sprite.texture = stand_texture
	lives = max_lives

func _on_hitbox_body_entered(body):
	if body.is_in_group("enemies") and not invincible and not body.is_captured:
		take_damage()
