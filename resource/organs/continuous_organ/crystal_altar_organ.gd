#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name CrystalAltarOrgan extends ContinuousOrgan

# TODO 机关：水晶祭坛 ===============>信 号<===============
#region 信号

#endregion

# TODO 机关：水晶祭坛 ===============>常 量<===============
#region 常量

#endregion

# TODO 机关：水晶祭坛 ===============>变 量<===============
#region 变量
var player : Player
var spawn_pos : Marker2D
@onready var point_light_2d: PointLight2D = $Light/PointLight2D
@onready var light: DeerPolygon = $Light
@onready var f_tip_panel_container: PanelContainer = %FTipPanelContainer
var is_enabled : bool = false
var line : Line2D
#endregion

# TODO 机关：水晶祭坛 ===============>虚方法<===============
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

		LoadAndSave.save_game()

		if Global.spawn_points.has(organ_name):
			spawn_pos.global_position = Global.spawn_points[organ_name]
			return

		if Global.spawn_points.has("红色水晶") and \
		Global.spawn_points.has("青色水晶") and \
		Global.spawn_points.has("紫色水晶"):
			Global.spawn_points[organ_name] = global_position + Vector2(0, -48)
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.parallel().tween_property(point_light_2d, "energy", 40, 4.5)
			tween.tween_property(light, "scale", Vector2.ONE * 20, 4.5)
			Dialogic.play_dialogic_context(preload("res://resource/dialogic/war_of_pursuit_paragraph.tres"), 1)
			await get_tree().create_timer(2).timeout
			Dialogic.next_dialogic_context()
			await get_tree().create_timer(2).timeout
			Dialogic.next_dialogic_context()
			await get_tree().create_timer(2).timeout
			Dialogic.next_dialogic_context()
			Global.ending_timer.stop()
			get_tree().get_first_node_in_group("OnlyUI").hide()
			get_tree().get_first_node_in_group("Thanks").show()
			return

		is_enabled = true
		f_tip_panel_container.hide()

		Global.spawn_points[organ_name] = global_position + Vector2(0, -48)
		spawn_pos.global_position = Global.spawn_points[organ_name]

		if organ_name == "紫色水晶":
			Global.is_war_of_pursuit = true

		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
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

# TODO 机关：水晶祭坛 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 机关：水晶祭坛：玩家进入信号方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if not is_enabled:
			if Global.key_tip_enabled:
				f_tip_panel_container.show()
		body.in_the_crystal = true
		player = body

# TODO_FUC 机关：水晶祭坛：玩家退出信号方法
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		line.clear_points()
		f_tip_panel_container.hide()
		body.in_the_crystal = false
		player = null
#endregion

# TODO 机关：光源祭坛 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 机关：光源祭坛：机关运行方法
func organ_run() -> void:
	pass
#endregion
