extends Area2D

var speed = 600 

func _ready() -> void: 
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	position += Vector2.from_angle(rotation) * speed * delta
	
func exit_screen() -> void: 
	print("bullet out")
	queue_free()

func _on_body_entered(body: Node) -> void:
	print("hit: ", body.name)
	
	if(body.has_method("handle_bullet_collision")):
		body.handle_bullet_collision()

	queue_free();
