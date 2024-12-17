#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name CDPanel extends PanelContainer

# TODO name ===============>信 号<===============
#region 信号
signal chick_cd_panel(index : int)
#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
var label: Label
var texture_rect: TextureRect
var text : String:
	set(v):
		text = v
		if not label:
			label = $Label
		label.text = text

var texture : Texture:
	set(v):
		texture = v
		if not texture_rect:
			texture_rect = $MarginContainer/TextureRect
		texture_rect.texture = texture

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

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _ready() -> void:
	focus_mode = FocusMode.FOCUS_CLICK

	# 游戏按钮：设置轴心为中心
	pivot_offset = size / 2

	if AudioManager.has_cd.size() > get_index():
		tooltip_text = AudioManager.has_cd[get_index()].cd_desc

func _make_custom_tooltip(for_text: String) -> Object:
	var tool_tip : TipToolPanelContainer = UiTool.TIP_TOOL_PANEL_CONTAINER.instantiate()
	tool_tip.set_tip_tool(AudioManager.has_cd[get_index()].cd_name, for_text, texture_rect.texture)
	return tool_tip
#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法
# CD UI：鼠标输入
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_left"):
			selected = true
			chick_cd_panel.emit(get_index())
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion
