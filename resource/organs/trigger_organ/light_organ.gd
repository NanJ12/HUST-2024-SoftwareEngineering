#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name LightOrgan extends TriggerOrgan

# TODO 灯 ===============>信 号<===============
#region 信号

#endregion

# TODO 灯 ===============>常 量<===============
#region 常量

#endregion

# TODO 灯 ===============>变 量<===============
#region 变量
@onready var point_light_2d: PointLight2D = $Light/PointLight2D
var is_open : bool = false:
	set(v):
		is_open = v
		if is_open:
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(point_light_2d, "energy", 2, 1.)
			await get_tree().create_timer(20).timeout
			is_open = false
		else :
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(point_light_2d, "energy", 0, 1.)
var is_in_light : bool = false
var player : Player
#endregion

# TODO 灯 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if player and not is_open and not is_in_light:
		if player.interact:
			is_open = true
			player.health_model.health -= 2


func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 灯 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 灯机关：玩家进入信号方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is LightAltarOrgan:
		is_in_light = true
		point_light_2d.energy = 2
		return
	if body is Player:
		player = body

# TODO_FUC 灯机关：玩家离开信号方法
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null
#endregion

# TODO 灯 ===============>工具方法<===============
#region 工具方法

#endregion
