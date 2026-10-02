extends CharacterBody2D

class_name Player

signal health_changed(new_health: float)

@export var speed := 300.0
@onready var map := $"../Background"
var health := 0.0
@export var max_health := 300.0
var move_direction := Vector2(0.0, 0.0)
var current_weapon : Node2D
var is_operating := false

# Dash
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown: Timer = $DashCooldown
@export var dash_duration := 2.0
@export var dash_speed_multi := 2.5
@export var dash_cd = 0.5
var dash_ready := true
var is_dashing := false

func _ready():
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	platform_floor_layers = 0
	platform_wall_layers = 0
	
	#print("PLAYER SCRIPT IS RUNNING")
	health = max_health
	

func _physics_process(delta):
	
	# dash过程种无法通过按键向其他方向移动
	if (is_dashing):
		velocity = move_direction * speed * dash_speed_multi
	else:
		var horizontal_direction = Input.get_axis("move_left", "move_right")
		var vertical_direction = Input.get_axis("move_up", "move_down")
		move_direction = Vector2(horizontal_direction, vertical_direction).normalized()
		velocity = move_direction * speed
	

	move_animation()
	move_and_slide()
	
	global_position.x = clamp(global_position.x, 0.0, map.size.x)
	global_position.y = clamp(global_position.y, 0.0, map.size.y)
	
	# 武器范围直接根据负责当前拿着武器的节点来旋转
	var facing = global_position.direction_to(get_global_mouse_position())
	if (not (is_dashing || is_operating)):
		$WeaponHolder.rotation = facing.angle()

func take_damage(damage):
	health -= damage
	health_changed.emit(health)
	#print("Player HP:", health)
	
func move_animation():
	if is_operating:
		return 
	$AnimatedSprite2D.flip_h = global_position.direction_to(get_global_mouse_position()).x < 0
	if move_direction:
		$AnimatedSprite2D.flip_h = move_direction.x < 0
		$AnimatedSprite2D.play("Run")
	else:
		$AnimatedSprite2D.play("Idle")
		
func equip_weapon(weapon_scene: PackedScene):
	current_weapon = $WeaponHolder.equip(weapon_scene)
	
#func _input(event):
	#if event.is_action_pressed("attack_1"):
		#print("Input")	
	
func _unhandled_input(event):
	if Input.is_action_pressed("attack_1"):
		#print("Unhandled")
		attack(1)
	if event.is_action_pressed("attack_2"):
		#print("Unhandled")
		attack(2)
	if Input.is_action_pressed("dash"):
		start_dash()
		

# the implementation limits the attack speed to be the same as 
# attack animation at the quickest
func attack(attack_index: int):
	if (current_weapon && not is_operating):
		# 如果可以攻击
		if current_weapon.attack(attack_index):
			is_operating = true
			# 动画过程中就应该进行攻击判定了
			$AnimatedSprite2D.play("Attack" + str(attack_index))	
			await $AnimatedSprite2D.animation_finished
			current_weapon.end_attack()
			is_operating = false

func start_dash():
	if (is_dashing \
	|| not dash_ready \
	|| move_direction == Vector2.ZERO):
		return 
		
	dash_timer.wait_time = dash_duration
	dash_timer.start()
	is_dashing = true

func _on_dash_timer_timeout() -> void:
	is_dashing = false
	dash_ready = false
	
	dash_cooldown.wait_time = dash_cd
	dash_cooldown.start()

func _on_dash_cooldown_timeout() -> void:
	dash_ready = true
