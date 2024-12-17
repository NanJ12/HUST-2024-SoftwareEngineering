#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name OrangeNPC extends TriggerOrgan

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量
@onready var f_tip_panel_container: PanelContainer = %FTipPanelContainer
var player : Player
var dialogic_is_play : bool = false
var dialogic_is_play_2 : bool = false
var player_is_far : bool = false:
	set(v):
		player_is_far = v
		if player_is_far:
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(self, "global_position", player.global_position + Vector2(0, -96), 1.)
			await tween.finished
			player_is_far = false
#endregion

# TODO name ===============>变 量<===============
#region 变量

#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if not player: return
	if not dialogic_is_play: return
	if dialogic_is_play_2: return
	if not player_is_far and global_position.distance_to(player.global_position) > 500:
		player_is_far = true


func _physics_process(_delta: float) -> void:
	if not player: return
	if player.interact and not dialogic_is_play:
		f_tip_panel_container.hide()
		Dialogic.play_dialogic_context(preload("res://resource/dialogic/adventurer_paragraph.tres"), 0)
		dialogic_is_play = true
	if player.interact and not dialogic_is_play_2 and dialogic_is_play and player.global_position.x < -34000:
		f_tip_panel_container.hide()
		Dialogic.play_dialogic_context(preload("res://resource/dialogic/adventurer_paragraph.tres"), 1)
		var memory_prop : MemoryProp = Global.MEMORY_PROP.instantiate()
		memory_prop.memory = preload("res://resource/memory_fragments/adventurer_1.tres")
		memory_prop.position = Vector2(96, 0)
		add_child(memory_prop)
		dialogic_is_play_2 = true

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if Global.key_tip_enabled:
			if not dialogic_is_play:
				f_tip_panel_container.show()
			elif dialogic_is_play and not dialogic_is_play_2 and player.global_position.x < -34000:
				f_tip_panel_container.show()
		player = body
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion
