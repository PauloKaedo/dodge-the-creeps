extends Area2D

export var speed = 400

var screenSize;

signal hit

func _ready():
	hide()
	screenSize = get_viewport_rect().size


func _process(delta):
	move_player(delta)


func move_player(delta) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	player_animations(velocity)
	position = limit_player(position)


func limit_player(position: Vector2) -> Vector2:
	position.x = clamp(position.x, 0, screenSize.x)
	position.y = clamp(position.y, 0, screenSize.y)
	return position
	
	
func player_animations(velocity: Vector2) -> void:
	
	if(velocity.length() > 0):
		$AnimatedSprite.play()
		
		if(velocity.x != 0):
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = velocity.x < 0
			
		if(velocity.y != 0):
			$AnimatedSprite.animation = "up"
			$AnimatedSprite.flip_v = velocity.y > 0
			$AnimatedSprite.flip_h = false
		
	else:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.stop()
	
	
func show_player(condition):
	if(condition):
		show()
	else:
		hide()
	


func hitted(body):
	hide()
	$CollisionShape2D.disabled = true
	emit_signal("hit")
