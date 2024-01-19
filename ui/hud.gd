extends Control

@onready var health_box := $"MarginContainer/HealthBox"
@onready var ammo_label := $"MarginContainer/Ammo"
@onready var pri_label := $"MarginContainer/PrimaryLoad"
@onready var sec_label := $"MarginContainer/SecondaryLoad"

func _on_health_changed(health : int):
	for chip : ColorRect in health_box.get_children():
		if health > 0:
			chip.color = 0xff0000ff
			health-=1
		else:
			chip.color = 0xffffff20

func _on_ammo_changed(ammo : int):
	ammo_label.text = str(ammo)

func _on_pri_load_change(load : int):
	pri_label.text = str(load) + " / 4"

func _on_sec_load_change(load : int):
	sec_label.text = str(load) + " / 4"
