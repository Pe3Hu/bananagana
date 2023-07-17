extends Node3D


@onready var anim_player = $AnimationPlayer


func move(direction_: Vector2):
	var keys = {}
	keys["Run Forward"] = Vector2(0, -1)
	keys["Run Backward"] = Vector2(0, 1)
	keys["Run Left"] = Vector2(-1, 0)
	keys["Run Right"] = Vector2(1, 0)
	
	keys["Run Forward Left"] = Vector2(-1, -1).normalized()
	keys["Run Forward Right"] = Vector2(1, -1).normalized()
	keys["Run Backward Left"] = Vector2(-1, 1).normalized()
	keys["Run Backward Right"] = Vector2(1, 1).normalized()
	
	var nearest = {}
	nearest.value = 2
	nearest.key = null
	
	for key in keys:
		var d = direction_.distance_to(keys[key])
		if d < nearest.value:
			nearest.value = d
			nearest.key = key
	
	anim_player.play(nearest.key)


func shoot():
	anim_player.stop()
	anim_player.play("Gunplay Standing")


func idle():
	anim_player.play("Rifle Aiming Idle")


func death(circumstances_: Dictionary):
	if circumstances_.headshot:
		anim_player.play("Death Headshot")
	else:
		anim_player.play("Death Rifle")


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Death Headshot":
			get_parent().rebirth()
		"Death Rifle":
			get_parent().rebirth()
