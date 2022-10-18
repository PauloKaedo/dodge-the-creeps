extends Node

export var Enemy: PackedScene 
var score = 0

func _ready():
	randomize()
	

func start_game():
	$HUD.update_score(score)
	$HUD.update_message('Prepare-se!')
	$Player.position = $StartPosition.position
	$Player/CollisionShape2D.disabled = false
	$Player.show_player(true)
	$HUD/StartBtn.hide()
	$StartTimer.start()

func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$SpawnTimer.start()
	

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func spawn_enemy():
	$EnemySpawn/PathEnemyFollow.offset = randi()
	var enemy = Enemy.instance()
	add_child(enemy)
	var direction = $EnemySpawn/PathEnemyFollow.rotation + PI/2
	enemy.position = $EnemySpawn/PathEnemyFollow.position
	direction += rand_range(-PI / 4, PI / 4)
	enemy.rotation = direction
	enemy.linear_velocity = Vector2(rand_range(enemy.min_speed, enemy.max_speed), 0)
	enemy.linear_velocity = enemy.linear_velocity.rotated(direction)


func game_over():
	$Player.position = $StartPosition.position
	$Player/CollisionShape2D.disabled = true
	$Sounds/Die.play()
	$ScoreTimer.stop()
	$SpawnTimer.stop()
	score = 0;
	$HUD.reset_game_hud()
	$HUD/StartBtn.show()
