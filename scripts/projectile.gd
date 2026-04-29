extends Area2D

var speed = 600 

func _ready() -> void: 
	$VisibleOnScreenNotifier2D.screen_exited.connect(exit_screen)
	$VisibleOnScreenNotifier2D.screen_entered.connect(func(): print("bullet IN"))
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	position += Vector2.from_angle(rotation) * speed * delta
	
func exit_screen() -> void: 
	print("bullet out")
	queue_free()


func _on_body_entered(body: Node) -> void:
	print("hit: ", body.name)
	body.queue_free()
	queue_free()
