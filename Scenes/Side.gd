extends StaticBody2D

func hit(ball_color):
	if GLOBALS.sound_fx: $"../BounceAudio".play()
	GLOBALS.lr_dir = -1
	$"../Ball/Particles2D".process_material.gravity.x = 1000

	var tween = $"../ColorTween"
	var rect_color =  $Rect.color.linear_interpolate(ball_color, GLOBALS.blend_factor)
	GLOBALS.tween_color(tween, $Rect, rect_color)
	#$Rect.color = rect_color
	GLOBALS.side_color = rect_color

	var bg_node = $"../Background"
	var bg_color = GLOBALS.background_blend()
	GLOBALS.tween_color(tween, bg_node, bg_color)
