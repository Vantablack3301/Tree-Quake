extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const BOB_FREQ = 2.0
const BOB_AMP = .08
var t_bob = 0.0

var look_rotation : Vector2

var mouse_captured : bool
@onready var head: Node3D = $Head
@onready var camera: Node3D = $Head/Camera3D
@onready var gun: Node3D = $Head/Camera3D/Gun

var look_speed = .002
@onready var shape_cast_3d: ShapeCast3D = $Head/Camera3D/ShapeCast3D

var keys:Array[key] = []

#ui stuff
@onready var key_container: HBoxContainer = $UiControl/keycContainer
const KEY_ICON = preload("res://key_icon.tscn")

func _ready() -> void:
	update_ui()
		
func update_ui():
	for x in key_container.get_children():
		x.queue_free()

	for key in keys:
		var new_key_icon:TextureRect = KEY_ICON.instantiate()
		key_container.add_child(new_key_icon)
	
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 7)
			velocity.z = lerp(velocity.z, direction.x * SPEED, delta * 7)
	else:
		velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 3)
		velocity.z = lerp(velocity.z, direction.x * SPEED, delta * 3)
	
	
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	move_and_slide()
	

	


func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		capture_mouse()
	
	if Input.is_key_pressed(KEY_ESCAPE):
		release_mouse()
		
	if mouse_captured and event is InputEventMouseMotion:
		rotate_look(event.relative)
		
	if Input.is_action_just_pressed("Shoot"):
		print("player just shot, idk why it isnt working")
		gun.Shoot()
	
	if Input.is_action_just_pressed("Interact"):
		if shape_cast_3d.is_colliding():
			var collisions = shape_cast_3d.get_collision_result()
			var collide = collisions[0]["collider"]
			print(collisions[0]["collider"])
			if collide.name == "KeyArea3D":
				#collide.get_parent().queue_free()
				pick_up_key(collide.owner)
			
func pick_up_key(key):
	keys.append(key.duplicate())
	key.queue_free()
	update_ui()
	

	

			
			
	
func rotate_look(rot_input : Vector2):
	look_rotation.x -= rot_input.y * look_speed
	look_rotation.x = clamp(look_rotation.x, deg_to_rad(-85), deg_to_rad(85))
	look_rotation.y -= rot_input.x * look_speed
	transform.basis = Basis()
	rotate_y(look_rotation.y)
	head.transform.basis = Basis()
	head.rotate_x(look_rotation.x)
	
func capture_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_captured = true
	
func release_mouse():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_captured = false
