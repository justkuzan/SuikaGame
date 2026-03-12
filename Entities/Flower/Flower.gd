extends RigidBody2D
class_name Flower

const DEFAULT_SPRITE = preload("uid://bxymses568v8i")

@export var flower_data: FlowerData

@onready var flower_sprite: Sprite2D = $FlowerSprite
@onready var flower_collision: CollisionShape2D = $FlowerCollision

var has_collided: bool = false


func _ready() -> void:
	update_flower()


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


func _on_body_entered(body: Node) -> void:
	if body is Flower:
		if flower_data == body.flower_data:
			if get_instance_id() > body.get_instance_id():
				SignalBus.flower_collide.emit(self.global_position, self.flower_data, self, body)
		else:
			if get_instance_id() > body.get_instance_id():
				SignalBus.flower_collide.emit(global_position, flower_data, self, body)
