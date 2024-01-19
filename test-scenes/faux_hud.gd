extends Control

@onready var hud = $"HUD"

# Called when the node enters the scene tree for the first time.
func _ready():
	hud._on_health_changed(2)
	hud._on_ammo_changed(20)
	hud._on_pri_load_change(2)
	hud._on_sec_load_change(1)
