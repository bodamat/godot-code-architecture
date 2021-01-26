extends Label


func _ready():
	GameEvents.connect("food_moused_over", self, "_on_food_hovered")
	GameEvents.connect("food_moused_out", self, "_on_food_unhovered")

func _on_food_hovered(food: Food) -> void:
	self.text = food.food_name
	self.visible = true

func _on_food_unhovered() -> void:
	self.visible = false
