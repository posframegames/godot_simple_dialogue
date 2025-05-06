extends CharacterBody2D
var dialog_area=null
var state="walking"

func _physics_process(delta):
	if state=="walking":
		velocity=Vector2(0,0)
		var v=300
		if Input.is_action_pressed("ui_left"):
			velocity.x=-v
		if Input.is_action_pressed("ui_right"):
			velocity.x=v		
		if Input.is_action_pressed("ui_up"):
			velocity.y=-v	
		if Input.is_action_pressed("ui_down"):
			velocity.y=v
		move_and_slide()	
		if Input.is_action_just_pressed("ui_accept"):
			if dialog_area!=null:
				state="dialog"
				dialog_area.reset_lines()
				$"../dialogue_panel".visible=true
				$"../dialogue_panel".set_lines(dialog_area.get_next_lines(0))
	elif state=="dialog":
		var res=$"../dialogue_panel".process_dialogue("ui_up","ui_down","ui_accept",dialog_area)
		if res==false:
			state="walking"
	


func _on_area_2d_area_entered(area):
	if area.is_in_group("dialogue_area"):
		dialog_area=area


func _on_area_2d_area_exited(area):
	if area.is_in_group("dialogue_area"):
		dialog_area=null
