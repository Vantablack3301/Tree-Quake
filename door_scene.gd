@tool
extends Node3D
class_name door


@export var door_id: String

var door_opened:bool = false
	

@onready var csg_box_3d: CSGBox3D = $CSGBox3D
func open_door():
	var new_tween:Tween = get_tree().create_tween()
	new_tween.tween_property(
		csg_box_3d,"position", Vector3(
		0.0,-2.0, 0.0
		), 0.2)
	door_opened = true

	
	
	 
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#open_door()
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if door_opened:
		return

	if body is Player:
		var player: Player = body
		
		for key in player.keys:
			if key.door_id == door_id:
				open_door()
				break

	
