#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name ColorChange extends Control

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
# # 颜色切换界面：颜色按钮
@onready var h_box_container: HBoxContainer = $HBoxContainer

@onready var color_1: GameButton = $HBoxContainer/Color1
@onready var color_2: GameButton = $HBoxContainer/Color2
@onready var color_3: GameButton = $HBoxContainer/Color3
# 颜色切换界面：初始位置
var current_pos : Vector2
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	for i in Global.player_colors.size():
		if Global.player_colors[i] == null:
			h_box_container.get_child(i).disabled = true

	#  链接按钮上的 pressed 信号
	color_1.pressed.connect(_on_color_1_pressed)
	color_2.pressed.connect(_on_color_2_pressed)
	color_3.pressed.connect(_on_color_3_pressed)
	if not current_pos:
		current_pos = global_position

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action_pressed("action_color_change"):
			if visible:
				await _close()
			visible = not visible

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
func _on_color_1_pressed() -> void:
	Global.player.player_color = Global.player_colors[0]

	await _close()
	hide()

func _on_color_2_pressed() -> void:
	Global.player.player_color = Global.player_colors[1]

	await _close()
	hide()

func _on_color_3_pressed() -> void:
	Global.player.player_color = Global.player_colors[2]

	await _close()
	hide()

# TODO_FUC 颜色切换页面：visible 切换的信号方法
func _on_visibility_changed() -> void:
	if visible:
		var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(self, "modulate:a", 1, .5)
		await tween.finished
		Engine.time_scale = .1

		for i in Global.player_colors.size():
			if Global.player_colors[i] == null:
				h_box_container.get_child(i).disabled = true
			else :
				h_box_container.get_child(i).disabled = false
				h_box_container.get_child(i).texture = Global.player_colors[i].player_color_texture
				h_box_container.get_child(i).icon = Global.player_colors[i].player_color_texture
				h_box_container.get_child(i).tooltip_text = Global.player_colors[i].player_color_desc
				h_box_container.get_child(i).text = Global.player_colors[i].player_color_name
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
# TODO_FUC 颜色切换界面：关闭
func _close() -> void:
	Engine.time_scale = 1
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate:a", 0, .5)
	await tween.finished

## TODO_FUC 颜色切换界面：隐藏方法
func _hide() -> void:
	Engine.time_scale = 1
	# 关闭暂停窗口
	hide()
#endregion
