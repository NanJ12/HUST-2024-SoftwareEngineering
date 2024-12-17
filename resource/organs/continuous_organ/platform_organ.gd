#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name PlatformOrgan extends ContinuousOrgan

# TODO 机关：平台 ===============>信 号<===============
#region 信号

#endregion

# TODO 机关：平台 ===============>常 量<===============
#region 常量

#endregion

# TODO 机关：平台 ===============>变 量<===============
#region 变量
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var f_tip_panel_container: PanelContainer = %FTipPanelContainer
var player : Player
static var is_tip : bool = false
static var tip_show : bool = false
#endregion

# TODO 机关：平台 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if not player: return
	if player.global_position.y < global_position.y:
		if Input.is_action_just_pressed("action_d"):
			f_tip_panel_container.hide()
			is_tip = true
			collision_shape_2d.disabled = true



func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 机关：平台 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 机关：平台：玩家进入信号方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if Global.key_tip_enabled and not is_tip and not tip_show:
			f_tip_panel_container.show()
			tip_show = true
		player = body
		if body.global_position.y > global_position.y:
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK)
			tween.tween_property(body, "global_position:y", global_position.y - 24, .25)
			print("玩家在下面")

# TODO_FUC 机关：平台：玩家退出信号方法
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		f_tip_panel_container.hide()
		tip_show = false
		player = null
		collision_shape_2d.set_deferred("disabled", false)
#endregion

# TODO 机关：平台 ===============>工具方法<===============
#region 工具方法

#endregion
