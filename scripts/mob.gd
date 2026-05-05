extends RigidBody2D

signal kill

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var mob_type = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_type.pick_random()
	$AnimatedSprite2D.play()
	
	$VisibleOnScreenNotifier2D.screen_exited.connect(exit_screen) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func exit_screen() -> void: 
	queue_free()
	print("exited")


func handle_bullet_collision() -> void:
	print("kill")
	queue_free() # Mob disappears after being hit.
