#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name LightAltarOrgan extends ContinuousOrgan

# TODO 机关：光源祭坛 ===============>信 号<===============
#region 信号

#endregion

# TODO 机关：光源祭坛 ===============>常 量<===============
#region 常量

#endregion

# TODO 机关：光源祭坛 ===============>变 量<===============
#region 变量
var player : Player
var spawn_pos : Marker2D
@onready var light: DeerPolygon = $Light
@onready var point_light_2d: PointLight2D = $Light/PointLight2D
@onready var f_tip_panel_container: PanelContainer = %FTipPanelContainer
var line : Line2D
var is_add_ending_timer : bool = false
#endregion

# TODO 机关：光源祭坛 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	spawn_pos = get_tree().get_first_node_in_group("SpawnPos")
	line = Line2D.new()
	line.default_color = Color.BEIGE
	line.default_color.a = .5
	line.width = 3
	add_child(line)
	move_child(line, 0)

func _process(_delta: float) -> void:
	if not player: return

	line.clear_points()
	line.add_point(Vector2.ZERO + Vector2(0, -48), 0)
	line.add_point(player.global_position - global_position, 1)

	if Input.is_action_just_pressed("action_interact"):
		spawn_pos.global_position = global_position + Vector2(0, -48)
		f_tip_panel_container.hide()

		if Global.is_war_of_pursuit and not is_add_ending_timer:
			Global.ending_timer.wait_time = Global.ending_timer.time_left + 45
			Global.ending_timer.start()
			is_add_ending_timer = true


		LoadAndSave.save_game()

		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(point_light_2d, "energy", 0, .75)
		tween.parallel().tween_property(point_light_2d, "energy", 4, .75)
		tween.tween_property(light, "scale", Vector2.ONE * 2, .75)
		tween.parallel().tween_property(point_light_2d, "energy", 2, .75)
		tween.tween_property(light, "scale", Vector2.ONE, .75)

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 机关：光源祭坛 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 机关：光源祭坛：玩家进入信号方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		body.can_heal_light = true
		player = body
		if spawn_pos.global_position == global_position + Vector2(0, -48): return
		if Global.key_tip_enabled:
			f_tip_panel_container.show()

# TODO_FUC 机关：光源祭坛：玩家退出信号方法
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		line.clear_points()
		f_tip_panel_container.hide()
		body.can_heal_light = false
		player = null
#endregion

# TODO 机关：光源祭坛 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 机关：光源祭坛：机关运行方法
func organ_run() -> void:
	pass
#endregion
