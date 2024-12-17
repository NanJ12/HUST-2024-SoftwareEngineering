#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name World extends Node2D

# TODO 世界场景 ===============>信 号<===============
#region 信号

#endregion

# TODO 世界场景 ===============>常 量<===============
#region 常量
#endregion

# TODO 世界场景 ===============>变 量<===============
#region 变量
@onready var player: Player = %Player

#endregion

# TODO 世界场景 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	get_tree().paused = false
	Global.player = player
	Global.world_environment = $WorldEnvironment
	Global.ending_timer = $EndingTimer
	Global.global_canvas_modulate = %GlobalCanvasModulate

	if Global.is_load_save:
		LoadAndSave.load_game()
	LoadAndSave.load_config()

	if AudioManager.cd:
		AudioManager.other_bgm_play(0)
		AudioManager.bgm_play()

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 世界场景 ===============>信号链接方法<===============
#region 信号链接方法
func _on_save_timer_timeout() -> void:
	LoadAndSave.save_game()
#endregion

# TODO 世界场景 ===============>工具方法<===============
#region 工具方法

#endregion
