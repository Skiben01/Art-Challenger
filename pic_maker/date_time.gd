extends Control

## Displays the Time

@onready var time: Label = $Time
@onready var date: Label = $Date

## Updates the time and date
func _ready() -> void:
	time.text = Time.get_time_string_from_system()
	date.text = Time.get_date_string_from_system()
