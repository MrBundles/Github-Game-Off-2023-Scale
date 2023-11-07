#@tool
#class_name name_of_class
extends CharacterBody2D

# purpose: This script will control the player character as well as handling all player/environment interactions

# signals ----------------------------------------------------------------------------------------------------------------

# enums ------------------------------------------------------------------------------------------------------------------

# constants --------------------------------------------------------------------------------------------------------------

# variables --------------------------------------------------------------------------------------------------------------
@export_group("Movement Variables")
@export var h_accel = 1
@export var h_decel = 1
@export var h_max = 1
@export var jump_accel = 1
@export var gravity = 1
@export var v_max = 1
@export var v_min = -1
@export var delta_mult = 1


# main functions ---------------------------------------------------------------------------------------------------------
func _ready():
	# connect signals
	
	# initialize setgets
	
	# initialize variables
	
	# call functions
	pass
	velocity


func _process(delta):
	input(delta)
	move_and_slide()


# helper functions --------------------------------------------------------------------------------------------------------
func input(delta):
	# handle horizontal input
	if Input.is_action_pressed("ui_left"):
		velocity.x = clamp(velocity.x - h_accel * delta * delta_mult, -h_max, h_max)
	elif Input.is_action_pressed("ui_right"):
		velocity.x = clamp(velocity.x + h_accel * delta * delta_mult, -h_max, h_max)
	elif velocity.x < -h_accel:
		velocity.x = clamp(velocity.x + h_accel * delta * delta_mult, -h_max, h_max)
	elif velocity.x > h_accel:
		velocity.x = clamp(velocity.x - h_accel * delta * delta_mult, -h_max, h_max)
	else:
		velocity.x = 0
	
	
	# handle vertical input
	if is_on_floor():
		$CoyoteTimer.start()
	
	if not $CoyoteTimer.is_stopped():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = clamp(velocity.y - jump_accel * delta * delta_mult, v_min, v_max)
	else:
		velocity.y = clamp(velocity.y + gravity * delta * delta_mult, v_min, v_max)
		print("grabity")
	
	if is_on_ceiling():
		velocity.x = 1
	
	print(is_on_ceiling())

# set/get functions -------------------------------------------------------------------------------------------------------


# signal functions --------------------------------------------------------------------------------------------------------



func _on_coyote_timer_timeout():
	$CoyoteTimer.stop()
