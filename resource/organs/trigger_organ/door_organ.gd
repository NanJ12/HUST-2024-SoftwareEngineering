#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name DoorOrgan extends TriggerOrgan

# TODO 机关：门 ===============>信 号<===============
#region 信号

#endregion

# TODO 机关：门 ===============>常 量<===============
#region 常量

#endregion

# TODO 机关：门 ===============>变 量<===============
#region 变量
@export var target_trigger_organ : TriggerOrgan
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
var is_falling : bool = true:
	set(v):
		is_falling = v
		if is_falling:
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(self, "global_position:y", current_pos.y + 96, .75)
		else :
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(self, "global_position:y", current_pos.y, .75)
var current_pos : Vector2
#endregion

# TODO 机关：门 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	current_pos = global_position

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 机关：门 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 机关：门：玩家退出方法
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		get_tree().create_timer(3).timeout.connect(func(): is_falling = true)
#endregion

# TODO 机关：门 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 机关类：机关运行方法
func organ_run() -> void:
	is_falling = false
#endregion
