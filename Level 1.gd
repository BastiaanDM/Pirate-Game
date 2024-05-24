extends Node

@onready var player = $Player
@onready var sword = $Sword
@onready var key = $Key
@onready var chest = $Chest
var has_key = false


# Called when the node enters the scene tree for the first time.
func _ready():
	sword.connect("Obtained_Sword", give_sword)
	key.connect("Key", give_key)
	chest.connect("Opened", open_chest)


func give_sword():
	player.has_sword = true

func give_key():
	has_key = true

func open_chest():
	sword.appear()
