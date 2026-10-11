class_name DeveloperTools
extends PanelContainer


# =========================================================
# Signals
# =========================================================

signal spawn_problem_requested
signal spawn_many_problems_requested(amount: int)
signal clear_problems_requested
signal spawn_uml_class_requested(name: String)


# =========================================================
# Buttons
# =========================================================

@onready var spawn_problem_button: Button = $MarginContainer/VBoxContainer/ButtonsPanel/ButtonsScrollContainer/MarginContainer/VBoxContainer/SpawnProblemButton
@onready var spawn_many_problems_button: Button = $MarginContainer/VBoxContainer/ButtonsPanel/ButtonsScrollContainer/MarginContainer/VBoxContainer/SpawnManyProblemsButton
@onready var clear_problems_button: Button = $MarginContainer/VBoxContainer/ButtonsPanel/ButtonsScrollContainer/MarginContainer/VBoxContainer/ClearProblemsButton
@onready var spawn_uml_class_button: Button = $MarginContainer/VBoxContainer/ButtonsPanel/ButtonsScrollContainer/MarginContainer/VBoxContainer/SpawnUMLClassButton

# =========================================================
# Console
# =========================================================

@onready var console_output: RichTextLabel = \
	$MarginContainer/VBoxContainer/ConsolePanel/MarginContainer/VBoxContainer/ConsoleOutput

@onready var console_input: LineEdit = \
	$MarginContainer/VBoxContainer/ConsolePanel/MarginContainer/VBoxContainer/HBoxContainer/ConsoleInput

@onready var submit_button: Button = \
	$MarginContainer/VBoxContainer/ConsolePanel/MarginContainer/VBoxContainer/HBoxContainer/SubmitButton


# =========================================================
# Initialization
# =========================================================

func _ready() -> void:
	visible = false
	_connect_buttons()
	_connect_console()

	console_output.scroll_following = true
	
	clear_log()
	log_info("Developer Tools initialized.")
	log_info("Type 'help' for available commands.")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_developer_tools"):
		visible = !visible
		get_viewport().set_input_as_handled()

func _connect_buttons() -> void:
	spawn_problem_button.pressed.connect(_on_spawn_problem_pressed)
	spawn_many_problems_button.pressed.connect(_on_spawn_many_problems_pressed)
	clear_problems_button.pressed.connect(_on_clear_problems_pressed)
	spawn_uml_class_button.pressed.connect(_on_spawn_uml_class_pressed)


func _connect_console() -> void:
	submit_button.pressed.connect(_submit_console_command)

	# 按 Enter 也可以提交
	console_input.text_submitted.connect(
		func(_text: String):
			_submit_console_command()
	)


# =========================================================
# Button Actions
# =========================================================
#region
func _on_spawn_problem_pressed() -> void:
	spawn_problem_requested.emit()

	log_info("Spawn Problem requested.")


func _on_spawn_many_problems_pressed() -> void:
	var amount := 20

	spawn_many_problems_requested.emit(amount)

	log_info("Spawn %d Problems requested." % amount)


func _on_clear_problems_pressed() -> void:
	clear_problems_requested.emit()

	log_info("Clear Problems requested.")


func _on_spawn_uml_class_pressed() -> void:
	pass
	#var class_name := "DebugClass"
#
	#spawn_uml_class_requested.emit(class_name)
#
	#log_info("Spawn UML Class requested: %s" % class_name)
#endregion

# =========================================================
# Console
# =========================================================
#region

func _submit_console_command() -> void:
	var command := console_input.text.strip_edges()

	if command.is_empty():
		return

	log_command(command)

	console_input.clear()
	console_input.grab_focus()

	_execute_command(command)


func _execute_command(command: String) -> void:
	var parts := command.split(" ", false)

	if parts.is_empty():
		return

	var command_name := parts[0].to_lower()

	match command_name:

		"help":
			_print_help()

		"spawn_problem":
			spawn_problem_requested.emit()
			log_info("Spawn Problem requested.")

		"spawn_many":
			var amount := 20

			if parts.size() >= 2:
				if parts[1].is_valid_int():
					amount = parts[1].to_int()
				else:
					log_error("Amount must be an integer.")
					return

			if amount <= 0:
				log_error("Amount must be greater than 0.")
				return

			spawn_many_problems_requested.emit(amount)

			log_info(
				"Spawn %d Problems requested." % amount
			)

		"clear_problems":
			clear_problems_requested.emit()

			log_info("Clear Problems requested.")

		"spawn_class":
			var name := "DebugClass"

			if parts.size() >= 2:
				name = parts[1]

			spawn_uml_class_requested.emit(name)

			log_info(
				"Spawn UML Class requested: %s" % name
			)

		"clear":
			console_output.clear()

		_:
			log_error(
				"Unknown command: %s" % command_name
			)


func _print_help() -> void:
	log_raw("""
Available Commands:

help
    Show available commands.

spawn_problem
    Spawn one test problem.

spawn_many [amount]
    Spawn multiple test problems.
    Example:
    spawn_many 50

clear_problems
    Clear all problems.

spawn_class [name]
    Spawn a UML class.
    Example:
    spawn_class Player

clear
    Clear console output.
""")
#endregion

# =========================================================
# Logging
# =========================================================
#region
func clear_log():
	console_output.clear()
	
func log_raw(message: String) -> void:
	console_output.append_text(message + "\n")


func log_info(message: String) -> void:
	_log("INFO", message)


func log_signal(message: String) -> void:
	_log("SIGNAL", message)


func log_warning(message: String) -> void:
	_log("WARNING", message)


func log_error(message: String) -> void:
	_log("ERROR", message)


func log_debug(message: String) -> void:
	_log("DEBUG", message)


func log_command(command: String) -> void:
	var time := Time.get_time_string_from_system()

	console_output.append_text(
		"[%s] > %s\n" % [
			time,
			command
		]
	)


func _log(type: String, message: String) -> void:
	var time := Time.get_time_string_from_system()

	console_output.append_text(
		"[%s] [%s] %s\n" % [
			time,
			type,
			message
		]
	)
#endregion
