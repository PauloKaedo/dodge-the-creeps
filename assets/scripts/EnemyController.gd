extends RigidBody2D

export var min_speed = 150
export var max_speed = 500

func _ready():
	var enemys = $AnimatedSprite.frames.get_animation_names()
	randomize()
	$AnimatedSprite.animation = enemys[randi() % enemys.size()]
	$AnimatedSprite.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
