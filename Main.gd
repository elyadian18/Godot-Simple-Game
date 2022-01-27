extends Node2D
var banana = preload("res://Banana.tscn")
var bananas = preload("res://Super Banana.tscn")
var bomb = preload("res://Bomb.tscn")
var screen_size=Vector2.ZERO
var nuke = preload("res://Nuke.tscn")

func _ready():
	screen_size=get_viewport_rect().size
	randomize()

func _process(delta):
	$BombTimer.wait_time= rand_range(0.3,4.0)
	$NukeTimer.wait_time= rand_range(1,5.0)	
	
	
func _on_BananaTimer_timeout():
	var m= banana.instance()
	var mobpath= $MobPath/MobSpawnLoc
	mobpath.unit_offset=rand_range(0.0,0.5)
	add_child(m)
	m.position=mobpath.position	

	

func start_game():
	$Monkey.show()
	global.kenyang=0
	$CanvasLayer.kenyang_update(global.kenyang)
	$BananaTimer.start()
	$BombTimer.start()
	$NukeTimer.start()
	$KenyangTimer.start()
	

func _on_BombTimer_timeout():
	var b = bomb.instance()
	add_child(b)
	var mobpath= $MobPath/MobSpawnLoc
	mobpath.unit_offset= rand_range(0.0,0.5)
	b.position=mobpath.position


func _on_NukeTimer_timeout():
	var n = nuke.instance()
	add_child(n)
	var mobpath= $MobPath/MobSpawnLoc
	mobpath.unit_offset= rand_range(0.0,0.5)
	n.position=mobpath.position


func _on_Monkey_hit():
	$Monkey.hide()
	$Booster.hide()
	$KenyangTimer.stop()
	$NukeTimer.stop()
	$BananaTimer.stop()
	$BananasTimer.stop()
	$BombTimer.stop()
	get_tree().call_group("Mobs","queue_free")
	get_tree().call_group("nukes","queue_free")
	get_tree().call_group("bombs","queue_free")
	$CanvasLayer.show_game_over()


func _on_KenyangTimer_timeout():
	$CanvasLayer.kenyang_update(global.kenyang)
	if global.kenyang == 10:
		$Booster.show()


func _on_BananasTimer_timeout():
	var m= bananas.instance()
	var mobpath= $MobPath/MobSpawnLoc
	mobpath.unit_offset=rand_range(0.0,0.5)
	add_child(m)
	m.position=mobpath.position


func _on_Booster_pressed():
	$Booster.hide()
	$BananasTimer.start()


func _on_Main_ready():
	$Booster.hide()
