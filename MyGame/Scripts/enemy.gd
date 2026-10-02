class_name Enemy
extends CharacterBody2D

@export var projectile_scene: PackedScene

@export var corpse_duration: float = 1.5
@export var health: float = 75.0
@export var speed: float = 80.0

@export var knockback_decay: float = 1200.0

# 击退撞击参数
@export var impact_damage: float = 10.0
@export var impact_min_speed: float = 50.0
@export_range(0.0, 1.0) var impact_transfer: float = 0.6

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox

var DEAD: bool = false

var player: Player
var map

var is_attacking: bool = false
var knockback_velocity: Vector2 = Vector2.ZERO

# 当前这次击退是否能够造成撞击伤害
var can_deal_impact: bool = false

# 当前这次击退已经撞伤的敌人
var impact_hit_targets: Dictionary = {}

var blink_tween: Tween


func _ready() -> void:
	if sprite.material:
		sprite.material = sprite.material.duplicate()

	hurtbox.entity = self


func setup(
	player_reference: Player,
	map_reference
) -> void:
	player = player_reference
	map = map_reference


func _physics_process(delta: float) -> void:
	# 先处理击退，让尸体也能继续滑动。
	if knockback_velocity.length() > 1.0:
		var push_velocity := knockback_velocity

		velocity = push_velocity
		move_and_slide()

		if can_deal_impact:
			check_knockback_impact(push_velocity)

		knockback_velocity = knockback_velocity.move_toward(
			Vector2.ZERO,
			knockback_decay * delta
		)

		if knockback_velocity.length() < impact_min_speed:
			can_deal_impact = false

		return

	knockback_velocity = Vector2.ZERO
	velocity = Vector2.ZERO
	can_deal_impact = false

	if DEAD:
		return

	if not is_instance_valid(player):
		return

	if is_attacking:
		move_and_slide()
		return

	var direction := global_position.direction_to(
		player.global_position
	)

	velocity = direction * speed

	sprite.play("Run")
	sprite.flip_h = direction.x < 0

	move_and_slide()


# ============================================================
# Shooting
# ============================================================

func shoot() -> void:
	if projectile_scene == null:
		return

	if DEAD or not is_instance_valid(player):
		return

	var projectile = projectile_scene.instantiate()

	projectile.setup(map)
	projectile.global_position = global_position
	projectile.direction = global_position.direction_to(
		player.global_position
	)

	get_tree().current_scene.add_child(projectile)


func _on_shoot_timer_timeout() -> void:
	if is_attacking or DEAD:
		return

	if not is_instance_valid(player):
		return

	is_attacking = true
	sprite.play("Attack")

	await sprite.animation_finished

	if DEAD:
		return

	is_attacking = false
	shoot()


# ============================================================
# Damage / Death
# ============================================================

func take_damage(amount: float) -> void:
	if DEAD:
		return

	health -= amount
	blink()

	if health <= 0.0:
		die()


func die() -> void:
	if DEAD:
		return

	DEAD = true
	is_attacking = false

	# 停止当前动画；如果有死亡动画，可改成 sprite.play("Death")。
	sprite.stop()

	# 保留身体碰撞，使尸体能继续滑动和撞击。
	await get_tree().create_timer(corpse_duration).timeout
	queue_free()


# ============================================================
# Blink Effect
# ============================================================

func blink(duration: float = 0.5) -> void:
	var material := sprite.material as ShaderMaterial

	if material == null:
		return

	# 避免多个闪烁 Tween 同时修改同一个参数。
	if blink_tween and blink_tween.is_valid():
		blink_tween.kill()

	blink_tween = create_tween()

	blink_tween.tween_method(
		func(value: float):
			material.set_shader_parameter(
				"blink_intensity",
				value
			),
		1.0,
		0.0,
		duration
	)


# ============================================================
# Knockback Effect
# ============================================================

func knockback(
	direction: Vector2,
	force: float,
	allow_impact: bool = true
) -> void:
	knockback_velocity = (
		direction.normalized() * maxf(force, 0.0)
	)

	can_deal_impact = allow_impact
	impact_hit_targets.clear()


# ============================================================
# Knockback Collision
# ============================================================

func check_knockback_impact(
	push_velocity: Vector2
) -> void:
	for i in range(get_slide_collision_count()):
		var collision := get_slide_collision(i)
		var other := collision.get_collider() as Enemy

		if other == null or other == self:
			continue

		if other.DEAD:
			continue

		var target_id := other.get_instance_id()

		if impact_hit_targets.has(target_id):
			continue

		# 碰撞法线指向自己，反方向用于推开对方。
		var push_direction := -collision.get_normal()

		# 取朝向碰撞面的速度分量，避免擦边也造成完整撞击。
		var impact_speed := push_velocity.dot(push_direction)

		if impact_speed < impact_min_speed:
			continue

		# 先记录命中，避免重复触发。
		impact_hit_targets[target_id] = true

		other.receive_knockback_impact(
			impact_damage,
			push_direction,
			impact_speed * impact_transfer
		)


func receive_knockback_impact(
	damage: float,
	direction: Vector2,
	force: float
) -> void:
	if DEAD:
		return

	# false：对方会被推开，但不会继续传播撞击伤害。
	# 先施加击退，使致死撞击也能让尸体滑动。
	knockback(direction, force, false)
	take_damage(damage)
