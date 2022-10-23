extends Node

var music = true
var sound_fx = true
var replay = false

var starting_color = Color(0.41, 0.41, 0.41, 1)
var top_color = starting_color
var bottom_color = starting_color
var side_color = starting_color
var blend_factor = 0.5
var blend_speed = 2

var ud_dir = 1
var lr_dir = 1
var player_speed = 600
var ball_speed = 500
var level = 1
var time = 0
var speed_increase = 10

func background_blend():
	var top = GLOBALS.top_color
	var side = GLOBALS.side_color
	var bottom = GLOBALS.bottom_color
	var mix1 = top.linear_interpolate(side, blend_factor)
	var mix2 = mix1.linear_interpolate(bottom, blend_factor)
	var mix3 = mix2.linear_interpolate(top, blend_factor)
	mix3.a = 0.5
	return mix3


func tween_color(tween, node, new_color):
	tween.interpolate_property(
		node,
		"color",
		node.color,
		new_color,
		blend_speed,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)
	tween.start()
