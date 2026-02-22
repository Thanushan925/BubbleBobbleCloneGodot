extends Node2D

var score : int = 0
var game_over_active : bool = false

@onready var hud = $HUD

func add_score(points : int):
	score += points
	hud.update_score(score)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hud.update_score(score)
	hud.update_lives($Player.lives)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if game_over_active and Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func game_over():
	print("GAME OVER")
	game_over_active = true
	$HUD.show_game_over()

func check_win_condition():
	var remaining = get_tree().get_nodes_in_group("enemies")

	if remaining.size() == 0 and not game_over_active:
		level_won()
		
func level_won():
	print("LEVEL COMPLETE!")
	game_over_active = true
	hud.show_win()
