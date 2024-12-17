#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
extends CanvasLayer

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@onready var rain: ColorRect = $Rain
@onready var snow: ColorRect = $Snow

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
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法

func _on_timer_timeout() -> void:
	var weather_index : int = randi() % 3
	if Global.player:
		if weather_index == 1 and Global.player.not_in_snowy_mountain:
			#switch_weather(0)
			return
	#switch_weather(weather_index)
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

func switch_weather(weather_index : int) -> void:
	match weather_index:
		0:
			await hide_weather(rain)
			await hide_weather(snow)
			if Global.player:
				Global.player.gliding_gravity_level = 4
		1:
			await hide_weather(rain)
			await show_weather(snow)
			# WARNING 雪天的效果还没写
			if Global.player:
				Global.player.gliding_gravity_level = 4
		2:
			await hide_weather(snow)
			await show_weather(rain)
			if Global.player:
				Global.player.gliding_gravity_level = 3

func show_weather(weather : ColorRect) -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(weather, "modulate:a", 1, 1.75)
	await tween.finished

func hide_weather(weather : ColorRect) -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(weather, "modulate:a", 0, 1.75)
	await tween.finished
#endregion
