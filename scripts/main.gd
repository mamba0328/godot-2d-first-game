extends Node

@export var mob_scene: PackedScene
@export var projectile_scene: PackedScene

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Handle Signals
	$Player.hit.connect(game_over)
	$Timers/StartTimer.timeout.connect(game_start)
	$Timers/ScoreTimer.timeout.connect(increase_score)
	$Timers/MobTimer.timeout.connect(spawn_mob)
	$Timers/ShootTimer.timeout.connect(shoot)
	$HUD.start_game.connect(new_game)
	print("connected")

func game_over() -> void:
	$Timers/ScoreTimer.stop()
	$Timers/MobTimer.stop()
	$Timers/ShootTimer.stop()
	$HUD.show_game_over()
	
	$BgMusic.stop()
	$GameOverSound.play()

func new_game() -> void:
	print("new game")
	#Start music
	$BgMusic.play()
	
	#Reset game state
	score = 0
	$Player.start($StartPosition.position)
	$Timers/StartTimer.start()

	
	#Clear all mobs
	get_tree().call_group("mobs", "queue_free")
	
	#Update UI
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func game_start() -> void:
	$Timers/MobTimer.start()
	$Timers/ScoreTimer.start()
	$Timers/ShootTimer.start()
	
func increase_score() -> void:
	score += 1
	$HUD.update_score(score)

func spawn_mob() -> void: 
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func shoot() -> void: 
	# Create a new instance of the projectile scene.
	var projectile = projectile_scene.instantiate()

	projectile.position = $Player.position + Vector2.from_angle($Player.current_direction) * 25
	projectile.rotation = $Player.current_direction

	add_child(projectile)
