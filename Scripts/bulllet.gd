extends CharacterBody3D

var wasShot = false
var _Speed = 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (wasShot):
		velocity = get_global_transform().basis.x * _Speed
		move_and_slide()
		velocity = Vector3.ZERO
	
		
		

		
func DebugShot(Speed: float, Transform: Transform3D):
	self.visible = true
	print("object was shot")
	_Speed = Speed
	transform = Transform
	wasShot = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("overlap")
	if body is Enemy:
		body.queue_free()
		
	queue_free()
