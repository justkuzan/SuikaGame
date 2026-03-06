extends RigidBody2D
class_name Flower

const DEFAULT_SPRITE = preload("uid://bxymses568v8i")

@export var flower_data: FlowerData

@onready var flower_sprite: Sprite2D = $FlowerSprite
@onready var flower_collision: CollisionShape2D = $FlowerCollision
@onready var lvl_label: Label = $LvlLabel


func _ready() -> void:
	SignalBus.debug_mode_changed.connect(update_label)
	update_flower()

	var current_level = get_tree().current_scene as Level

	if current_level:
		update_label(current_level.is_debug_enabled)
	else:
		update_label(false)


func update_flower() -> void:
	if not is_node_ready(): return
	if flower_data and flower_data.sprite:
		flower_sprite.texture = flower_data.sprite
	else:
		flower_sprite.texture = DEFAULT_SPRITE

	if flower_data and flower_collision.shape is CircleShape2D:
		flower_collision.shape.radius = flower_data.collision_radius
	else:
		print("There is no shape on Flower!")

	if flower_data:
		mass = flower_data.mass


func update_label(mode: bool) -> void:
	if flower_data:
		lvl_label.text = "%d" % flower_data.lvl

	lvl_label.visible = mode


func _on_body_entered(body: Node) -> void:
	if body is Flower:
		if flower_data == body.flower_data:
			if get_instance_id() > body.get_instance_id():
				SignalBus.flower_collide.emit(self.global_position, self.flower_data, self, body)
