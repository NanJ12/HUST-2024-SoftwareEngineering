#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name PurpleNPC extends TriggerOrgan

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
var player : Player
@onready var f_tip_panel_container: PanelContainer = %FTipPanelContainer
var is_war : bool = false
@onready var timer: Timer = $Timer
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	Global.war_of_pursuit.connect(_on_global_war_of_pursuit)
	await get_tree().process_frame
	Global.ending_timer.timeout.connect(_on_globel_safe_lumine)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if not player: return
	if player.interact and not is_war:
		f_tip_panel_container.hide()
		print("播放对话")

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if Global.key_tip_enabled and not is_war:
			f_tip_panel_container.show()
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		f_tip_panel_container.hide()
		player = null

func _on_global_war_of_pursuit() -> void:
	is_war = true
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position", Global.player.global_position + Vector2(-192, -192), 4.5)
	await tween.finished
	timer.start(2)
	timer.autostart = true
	Dialogic.play_dialogic_context(preload("res://resource/dialogic/war_of_pursuit_paragraph.tres"), 0)
	await Dialogic.dialogic_is_ending
	Global.spawn_points.erase("橙色水晶")

func _on_timer_timeout() -> void:
	if not Dialogic.dialogic_is_playing:
		timer.stop()
		timer.autostart = false
		Dialogic.exit_dialogic()
		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "global_position", Global.player.global_position, .5)
		Global.player.health_model.health -= Global.player.health_model.max_health * .75
		await tween.finished
		Global.player.hurt_dir = Vector2(1, -1)
		Global.player.is_hurt = true
		get_tree().create_timer(.15).timeout.connect(func():
			var tween2 : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween2.tween_property(self, "global_position", Global.player.global_position + Vector2(-192, -192), .5)
			Global.player.is_hurt = false
			await tween2.finished
			Global.evil_lumine_is_relly_attack = true
			)
	else :
		Dialogic.next_dialogic_context()

func _on_globel_safe_lumine() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position", Global.player.global_position, .5)
	await tween.finished
	Global.player.health_model.health -= Global.player.health_model.max_health
	Global.player.hurt_dir = Vector2(1, -1)
	Global.player.is_hurt = true
	await get_tree().create_timer(1.5).timeout
	var tween2 : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween2.tween_property(self, "global_position", Global.player.global_position + Vector2(-192, -192), .5)
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion
