extends Area

class_name Food

func _ready():
	GameEvents.connect("food_moused_over", self, "_on_mouse_entered")
	GameEvents.connect("food_moused_out", self, "_on_mouse_out")

func _on_mouse_entered(food: Food):
	if food == self:
		$SpotLight.visible = true

func _on_mouse_out():
	$SpotLight.visible = false
