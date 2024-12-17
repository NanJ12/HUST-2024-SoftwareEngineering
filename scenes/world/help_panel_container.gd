#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends VBoxContainer

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var fold: Button = $Fold
var pop_up : bool = false:
	set(v):
		pop_up = v
		if pop_up:
			stats_open()
		else:
			stats_close()
# 这个UI加载完毕后的位置
var current_pos : Vector2
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

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
func _on_fold_pressed() -> void:
	pop_up = not pop_up
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
func stats_open() -> void:
	if not current_pos:
		current_pos = position
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "global_position:y", 0, 1)

func stats_close() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "global_position:y", current_pos.y, 1)
#endregion
