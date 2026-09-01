extends CanvasLayer

var player
var current_health : float
@onready var health_bar = $MarginContainer/HBoxContainer/StatusPanel/VBoxContainer/HealthBar/HPBar
@onready var ItemsHotbar = $ItemsHotbarContainer/ItemsHotbar
func setup(player_reference):
	
	#这里竟然还是把player的血条绑定在最高层，需要修改
	player = player_reference
	current_health = player.max_health
	health_bar.max_value = player.max_health
	#print(health_bar.max_value)
	player.health_changed.connect(update_health_bar)
	
	ItemsHotbar.setup(player_reference)
	

func update_health_bar(new_health):
	current_health = new_health
	
func _process(delta):
	health_bar.value = lerp(
		health_bar.value,
		current_health,
		15.0 * delta
	)
