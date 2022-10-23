extends KinematicBody2D

func _physics_process(delta):
	var collision = ball_movement(delta)
	handle_collision(collision)


func ball_movement(delta):
	var velocity = Vector2.ZERO
	velocity.y -= 1 * GLOBALS.ud_dir
	velocity.x += 1 * GLOBALS.lr_dir
	return move_and_collide(velocity.normalized() * GLOBALS.ball_speed * delta)


func handle_collision(collision):
	if collision:
		var collider = collision.collider
		if collider.has_method('hit'):
			# Pass the ball color
			collider.hit($BallRect.color)
