extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):
	# immediately break if paused, player is not allowed to move while paused
	if SceneManager.scene == SceneManager.SCENE_STATE.PAUSE:
		return

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horiz_direction = Input.get_axis("right", "left")
	var vert_direction = Input.get_axis("down", "up")
	if horiz_direction:
		velocity.x = horiz_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if vert_direction:
		velocity.y = vert_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
