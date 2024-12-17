#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name PressurePlateOrgan extends TriggerOrgan

# TODO 机关：压力板 ===============>信 号<===============
#region 信号

#endregion

# TODO 机关：压力板 ===============>常 量<===============
#region 常量

#endregion

# TODO 机关：压力板 ===============>变 量<===============
#region 变量
@export var target_trigger_organs : Array[TriggerOrgan]
var player : Player
var move_block : MovableBlockOrgan
static var is_tip : bool = false
static var tip_show : bool = false
@onready var f_tip_panel_container: PanelContainer = %FTipPanelContainer
#endregion

# TODO 机关：压力板 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if player:
		if target_trigger_organs:
			for i in target_trigger_organs:
				i.is_trigger = true
	elif move_block:
		if target_trigger_organs:
			for i in target_trigger_organs:
				i.is_trigger = true
	else :
		if target_trigger_organs:
			await get_tree().create_timer(.5).timeout
			for i in target_trigger_organs:
				i.is_trigger = false

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 机关：压力板 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 机关：压力板：玩家进入方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:

		player = body

		if Global.key_tip_enabled and not is_tip and not tip_show:
			f_tip_panel_container.show()
			tip_show = true
			is_tip = true
			await get_tree().create_timer(3).timeout
			f_tip_panel_container.hide()

	if body is MovableBlockOrgan:
		move_block = body

# TODO_FUC 机关：压力板：玩家退出方法
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null

	if body is MovableBlockOrgan:
		move_block = body
#endregion

# TODO 机关：压力板 ===============>工具方法<===============
#region 工具方法

#endregion
