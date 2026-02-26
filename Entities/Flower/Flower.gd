extends RigidBody2D
class_name Flower

const DEFAULT_SPRITE = preload("uid://bxymses568v8i")

@export var flower_data: FlowerData

@onready var flower_sprite: Sprite2D = $FlowerSprite
@onready var flower_collision: CollisionShape2D = $FlowerCollision


func _ready() -> void:
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


func _physics_process(delta: float) -> void:
	if linear_velocity.y > 0:
		gravity_scale = 2.0
		linear_damp = 0.0
	else:
		gravity_scale = 1.0

		if linear_velocity.length() < 5:
			linear_damp = 5
		else:
			linear_damp = 0.5


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("flowers"):
		if body is Flower:
			if flower_data == body.flower_data:
				if get_instance_id() > body.get_instance_id():
					SignalBus.on_flower_collide.emit(self.global_position, self.flower_data, self, body)
