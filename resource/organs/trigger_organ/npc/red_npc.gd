#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name RedNPC extends TriggerOrgan

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
var player : Player
var dialogic_is_play : bool = false
@onready var f_tip_panel_container: PanelContainer = %FTipPanelContainer
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if not player: return
	if player.interact and not dialogic_is_play:
		f_tip_panel_container.hide()
		if Global.red_dialogic_enabled:
			Dialogic.play_dialogic_context(preload("res://resource/dialogic/red_paragraph.tres"), 1)
		else :
			Dialogic.play_dialogic_context(preload("res://resource/dialogic/red_paragraph.tres"), 0)
		dialogic_is_play = true
		Global.red_dialogic_enabled = true

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
			f_tip_panel_container.show()
		player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		f_tip_panel_container.hide()
		player = null
		dialogic_is_play = false
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion