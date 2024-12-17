#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name TranPointPanelContainer extends PanelContainer

# TODO 传送条 UI  ===============>信 号<===============
#region 信号
signal selected_panel(pos : Vector2, index : int)
#endregion

# TODO 传送条 UI  ===============>常 量<===============
#region 常量

#endregion

# TODO 传送条 UI  ===============>变 量<===============
#region 变量
var pos : Vector2
var label: Label
var text : String:
	set(v):
		text = v

		if label:
			label.text = text
		else :
			label = $MarginContainer/HBoxContainer/Label
			label.text = text
var selected : bool = false:
	set(v):
		selected = v
		if selected:
			z_index = 100
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(self, "scale", Vector2.ONE * 1.1, .5)
		else :
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
			tween.tween_property(self, "scale", Vector2.ONE, .5)

#endregion

# TODO 传送条 UI  ===============>虚方法<===============
#region 虚方法
func _ready() -> void:
	focus_mode = FocusMode.FOCUS_CLICK

	# 游戏按钮：设置轴心为中心
	pivot_offset = size / 2
#endregion

# TODO 传送条 UI  ===============>信号链接方法<===============
#region 信号链接方法
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_left"):
			selected = true
			selected_panel.emit(pos, get_index())
#endregion

# TODO 传送条 UI  ===============>工具方法<===============
#region 工具方法

#endregion
