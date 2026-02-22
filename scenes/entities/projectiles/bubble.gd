extends Area2D

@export var speed : float = 250.0
@export var float_speed : float = 100.0
@export var horizontal_time : float = 0.5

var dir : int = 1
var float_up : bool = false

var trapped_enemy : CharacterBody2D = null
var can_pop : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	
	# After horizontal_time, switch to floating
	await get_tree().create_timer(0.2).timeout
	can_pop = true
	
	await get_tree().create_timer(horizontal_time).timeout
	float_up = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if float_up:
		position.y -= float_speed * delta
	else:
		position.x += dir * speed * delta
	
	if trapped_enemy != null:
		trapped_enemy.global_position = global_position
	
	if global_position.y < 40:
		global_position.y = 50
	elif global_position.x < 40:
		global_position.x = 50
	elif global_position.x > 1110:
		global_position.x = 1100



func _on_timer_timeout():
	if trapped_enemy != null:
		release_enemy()
	
	queue_free()
	
func release_enemy():
	trapped_enemy.is_captured = false
	trapped_enemy.set_physics_process(true)
	
	trapped_enemy.get_node("CollisionShape2D").disabled = false
	
	trapped_enemy.global_position = global_position
	trapped_enemy = null



func _on_body_entered(body):
	if body.is_in_group("enemies") and not body.is_captured and trapped_enemy == null:
		trap_enemy(body)
	
	if body.is_in_group("player") and trapped_enemy != null and can_pop:
		pop_bubble()



func trap_enemy(enemy):
	trapped_enemy = enemy

	enemy.is_captured = true
	enemy.velocity = Vector2.ZERO
	enemy.set_physics_process(false)
	enemy.get_node("CollisionShape2D").disabled = true

	# Start a timer for enemy rage
	var rage_timer = Timer.new()
	rage_timer.one_shot = true
	rage_timer.wait_time = enemy.rage_delay
	add_child(rage_timer)
	rage_timer.start()
	rage_timer.timeout.connect(func() -> void:
		if trapped_enemy == enemy:
			enemy_escape(enemy)
	)
	

func enemy_escape(enemy):
	# Remove from bubble
	trapped_enemy = null
	enemy.is_captured = false
	enemy.set_physics_process(true)
	enemy.get_node("CollisionShape2D").disabled = false
	enemy.global_position = global_position  # starts from bubble position

	# Put enemy in rage mode
	enemy.is_raging = true
	enemy.velocity.x = enemy.direction * enemy.SPEED * enemy.rage_speed_multiplier


func pop_bubble():
	if trapped_enemy != null:
		trapped_enemy.queue_free()
		trapped_enemy = null

	await get_tree().process_frame

	if get_tree().current_scene != null:
		get_tree().current_scene.check_win_condition()

	queue_free()
