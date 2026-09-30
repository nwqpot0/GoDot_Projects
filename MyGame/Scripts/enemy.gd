class_name Enemy
extends CharacterBody2D


@export var projectile_scene: PackedScene

@export var health: float = 75.0
@export var speed: float = 80.0

@export var knockback_decay: float = 1200.0


@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Hurtbox


var player: Player
var map

var is_attacking: bool = false

# 当前的击退速度
var knockback_velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	# 每个 Enemy 拥有独立 ShaderMaterial
	if sprite.material:
		sprite.material = sprite.material.duplicate()

	# Hurtbox 指向真正的 Enemy 实体
	hurtbox.entity = self


func setup(
	player_reference: Player,
	map_reference
) -> void:
	player = player_reference
	map = map_reference


func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return

	# -------------------------
	# Knockback
	# -------------------------

	if knockback_velocity.length() > 1.0:
		velocity = knockback_velocity

		knockback_velocity = knockback_velocity.move_toward(
			Vector2.ZERO,
			knockback_decay * delta
		)

		move_and_slide()
		return


	# -------------------------
	# Attacking
	# -------------------------

	if is_attacking:
		velocity = Vector2.ZERO
		move_and_slide()
		return


	# -------------------------
	# Normal Movement
	# -------------------------

	var direction: Vector2 = global_position.direction_to(
		player.global_position
	)

	velocity = direction * speed

	sprite.animation = "Run"
	sprite.flip_h = direction.x < 0

	move_and_slide()


# ============================================================
# Shooting
# ============================================================

func shoot() -> void:
	if projectile_scene == null:
		return

	if not is_instance_valid(player):
		return

	var projectile = projectile_scene.instantiate()

	projectile.setup(map)

	projectile.global_position = global_position

	projectile.direction = global_position.direction_to(
		player.global_position
	)

	get_tree().current_scene.add_child(projectile)


func _on_shoot_timer_timeout() -> void:
	if is_attacking:
		return

	is_attacking = true

	sprite.play("Attack")

	await sprite.animation_finished

	# await 期间 Enemy 可能已经死亡
	if not is_instance_valid(self):
		return

	is_attacking = false

	shoot()


# ============================================================
# Damage
# ============================================================

func take_damage(amount: float) -> void:
	health -= amount

	blink()

	if health <= 0.0:
		die()


func die() -> void:
	queue_free()


# ============================================================
# Blink Effect
# ============================================================

func blink(duration: float = 0.5) -> void:
	var material := sprite.material as ShaderMaterial

	if material == null:
		return

	var tween := create_tween()

	tween.tween_method(
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
	force: float
) -> void:
	knockback_velocity = (
		direction.normalized()
		* force
	)
