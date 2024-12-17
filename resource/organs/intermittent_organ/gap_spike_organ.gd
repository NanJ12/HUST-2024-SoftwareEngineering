#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name GapSpikeOrgan extends IntermittentOrgan

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var timer: Timer = $Timer
var current_pos : Vector2
@onready var gap_spike_organ: GapSpikeOrgan = $"."
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	current_pos = global_position
	timer.start(organ_time)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC
func _on_timer_timeout() -> void:
	gap_spike_organ.visible = not gap_spike_organ.visible
	collision_shape_2d.disabled = not collision_shape_2d.disabled

# TODO_FUC 机关：尖刺机关：玩家进入方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.is_hurt:
			return

		if body.global_position.x < global_position.x:
			body.hurt_dir.x = -1
		elif body.global_position.x > global_position.x :
			body.hurt_dir.x = 1

		if body.global_position.y > global_position.y:
			body.hurt_dir.y = 1
		elif body.global_position.y < global_position.y :
			body.hurt_dir.y = -1

		body.is_hurt = true
		body.health_model.health -= 3

# TODO_FUC 机关：尖刺机关：玩家退出方法
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		body.is_hurt = false
		print('受伤')

#endregion

# TODO 机关：尖刺机关 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 机关：尖刺机关：机关运行方法
func organ_run() -> void:
	pass
#endregion
