#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name HorizontalPlatformOrgan extends IntermittentOrgan

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
var is_left : bool = true:
	set(v):
		is_left = v
		if is_left:
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(self, "global_position:x", current_pos.x + (-48 * 3), 2.5)
		else :
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(self, "global_position:x", current_pos.x + (48 * 3), 2.5)
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
	is_left = not is_left
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion
