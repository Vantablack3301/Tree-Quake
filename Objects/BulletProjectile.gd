extends Area3D

class_name Bullet

var _Speed = 50

var wasShot = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if (wasShot):
		position = transform.basis.x * _Speed * delta
	
func DebugShot(Speed: float, Transform: Transform3D):
	self.visible = true
	print("object was shot")
	_Speed = Speed
	transform = Transform
	wasShot = true
