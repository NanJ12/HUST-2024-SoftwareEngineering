#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name ColorOrgan extends ContinuousOrgan

# TODO 颜色方块机关 ===============>信 号<===============
#region 信号

#endregion

# TODO 颜色方块机关 ===============>常 量<===============
#region 常量

#endregion

# TODO 颜色方块机关 ===============>变 量<===============
#region 变量
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var f_tip_panel_container: PanelContainer = %FTipPanelContainer
static var is_tip : bool = false
static var tip_show : bool = false
#endregion

# TODO 颜色方块机关 ===============>虚方法<===============
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

# TODO 颜色方块机关 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 颜色方块机关：玩家进入检测的信号方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if Global.key_tip_enabled and not tip_show and not is_tip:
			f_tip_panel_container.show()
			tip_show = true
		if absf(body.velocity.x) > 500:
			f_tip_panel_container.hide()
			is_tip = true
			var camera : Camera = get_viewport().get_camera_2d()
			camera.shake_camera(.3, 4)
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(body, "global_position:x", global_position.x + (48 * body.last_dir), .5)
			tween.parallel().tween_property(point_light_2d, "energy", 1., .3)
			tween.tween_interval(3)
			tween.parallel().tween_property(point_light_2d, "energy", 0., 1.5)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		f_tip_panel_container.hide()
		tip_show = false
#endregion

# TODO 颜色方块机关 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 机关类：机关运行方法
func organ_run() -> void:
	pass
#endregion
