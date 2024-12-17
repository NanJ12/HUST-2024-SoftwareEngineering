#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name CrayNPC extends TriggerOrgan

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var timer: Timer = $Timer
var player : Player
var dialogic_is_play : bool = false:
	set(v):
		dialogic_is_play = v
		if dialogic_is_play:
			timer.start(2)
			timer.autostart = true
			Dialogic.play_dialogic_context(preload("res://resource/dialogic/start_learning_paragraph.tres"), 0)
			await Dialogic.dialogic_is_ending
			timer.stop()
			timer.autostart = false

var player_is_in_jump_area : bool = false:
	set(v):
		player_is_in_jump_area = v
		if player_is_in_jump_area:
			timer.start(2)
			timer.autostart = true
			if Dialogic.dialogic_is_playing:
				Dialogic.exit_dialogic()
			Dialogic.play_dialogic_context(preload("res://resource/dialogic/start_learning_paragraph.tres"), 1)
			await Dialogic.dialogic_is_ending
			Global.learning_jumping = true
			timer.stop()
			timer.autostart = false

var player_is_in_glide_area : bool = false:
	set(v):
		player_is_in_glide_area = v
		if player_is_in_glide_area:
			timer.start(2)
			timer.autostart = true
			if Dialogic.dialogic_is_playing:
				Dialogic.exit_dialogic()
			Dialogic.play_dialogic_context(preload("res://resource/dialogic/start_learning_paragraph.tres"), 2)
			await Dialogic.dialogic_is_ending
			Global.learning_gliding = true
			timer.stop()
			timer.autostart = false

var player_is_in_sprint_area : bool = false:
	set(v):
		player_is_in_sprint_area = v
		if player_is_in_sprint_area:
			timer.start(2)
			timer.autostart = true
			if Dialogic.dialogic_is_playing:
				Dialogic.exit_dialogic()
			Dialogic.play_dialogic_context(preload("res://resource/dialogic/start_learning_paragraph.tres"), 3)
			await Dialogic.dialogic_is_ending
			Global.learning_sprinting = true
			timer.stop()
			timer.autostart = false

var player_is_in_ending_area : bool = false:
	set(v):
		player_is_in_ending_area = v
		if player_is_in_ending_area:
			timer.start(2)
			timer.autostart = true
			if Dialogic.dialogic_is_playing:
				Dialogic.exit_dialogic()
			Dialogic.play_dialogic_context(preload("res://resource/dialogic/start_learning_paragraph.tres"), 4)
			await Dialogic.dialogic_is_ending
			timer.stop()
			timer.autostart = false
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	Global.ready_safe_lumine.connect(_on_global_safe)

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if not player: return
	if not dialogic_is_play:
		dialogic_is_play = true

	if player.global_position.x > -1700 and \
	not Global.is_war_of_pursuit and \
	player.global_position.x < -1400 and \
	player_is_in_jump_area == false and \
	not Dialogic.dialogic_is_playing:
		player_is_in_jump_area = true

	if player.global_position.x <= -1700 and \
	not Global.is_war_of_pursuit and \
	player.global_position.x > -3000 and \
	player_is_in_glide_area == false and \
	Global.learning_jumping and \
	not Dialogic.dialogic_is_playing:
		player_is_in_glide_area = true

	if player.global_position.x <= -3000 and \
	not Global.is_war_of_pursuit and \
	player.global_position.x > -5000 and \
	player_is_in_sprint_area == false and \
	Global.learning_gliding and \
	not Dialogic.dialogic_is_playing:
		player_is_in_sprint_area = true

	if player.global_position.x <= -5000 and \
	not Global.is_war_of_pursuit and \
	player_is_in_ending_area == false and \
	Global.learning_sprinting and \
	not Dialogic.dialogic_is_playing:
		player_is_in_ending_area = true


func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body

func _on_global_safe() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position", Global.player.global_position + Vector2(0, -192), 1.)
	await tween.finished
	timer.start(2)
	timer.autostart = true
	Dialogic.play_dialogic_context(preload("res://resource/dialogic/start_learning_paragraph.tres"), 5)
	await Dialogic.dialogic_is_ending
	timer.stop()
	timer.autostart = false

	Global.ending_timer.start(40)
	get_tree().get_first_node_in_group("OnlyUI").show()
	Global.global_canvas_modulate.show()

func _on_timer_timeout() -> void:
	if Dialogic.visible:
		Dialogic.next_dialogic_context()
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion
