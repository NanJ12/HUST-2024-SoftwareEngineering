#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name StatsPanelContainer extends HBoxContainer

# TODO 属性面板 UI ===============>信 号<===============
#region 信号
@onready var fold: Button = $Fold
@onready var life_num: Label = %life_num
@onready var strength_num: Label = %strength_num
@onready var speed_num: Label = %speed_num
@onready var jump_num: Label = %jump_num
@onready var sprint_cd_num: Label = %sprint_cd_num


@onready var player: Player = %Player
var pop_up : bool = false:
	set(v):
		pop_up = v
		if pop_up:
			stats_open()
		else:
			stats_close()

#endregion

# TODO 属性面板 UI ===============>常 量<===============
#region 常量

#endregion

# TODO 属性面板 UI ===============>变 量<===============
#region 变量
# 这个UI加载完毕后的位置
var current_pos : Vector2
#endregion

# TODO 属性面板 UI ===============>虚方法<===============
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

# TODO 属性面板 UI ===============>信号链接方法<===============
#region 信号链接方法
func _on_fold_pressed() -> void:
	pop_up = not pop_up
#endregion

# TODO 属性面板 UI ===============>工具方法<===============
#region 工具方法
func stats_open() -> void:
	update_value()

	if not current_pos:
		current_pos = position

	fold.text = "收\n起"
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SPRING)
	tween.tween_property(self, "global_position:x", current_pos.x - 760, 1)

func stats_close() -> void:
	fold.text = "展\n开"
	var tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "global_position:x", current_pos.x, 1)

# TODO_FUC 属性栏 : 数值获取
func update_value():
	life_num.text = str(player.health_model.max_health)
	strength_num.text = str(player.strength_model.max_strength)
	speed_num.text = str(player.speed)
	jump_num.text = str(player.jump_speed)
	sprint_cd_num.text = str(player.max_sprint_cd)
#endregion
