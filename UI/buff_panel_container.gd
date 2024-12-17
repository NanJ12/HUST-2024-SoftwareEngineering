#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name BuffPanelContainer extends PanelContainer

# TODO Buff 图标面板 ===============>信 号<===============
#region 信号

#endregion

# TODO Buff 图标面板 ===============>常 量<===============
#region 常量

#endregion

# TODO Buff 图标面板 ===============>变 量<===============
#region 变量
var texture_rect: TextureRect

#endregion

# TODO Buff 图标面板 ===============>虚方法<===============
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

func _make_custom_tooltip(for_text: String) -> Object:
	var tool_tip : TipToolPanelContainer = UiTool.TIP_TOOL_PANEL_CONTAINER.instantiate()
	tool_tip.set_tip_tool(Global.player.buffs[get_index()].buff_name, for_text, texture_rect.texture)
	return tool_tip
#endregion

# TODO Buff 图标面板 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO Buff 图标面板 ===============>工具方法<===============
#region 工具方法
# TODO_FUC
func set_buff_panel(texture : Texture2D) -> void:
	tooltip_text = Global.player.buffs[get_index()].buff_desc
	texture_rect = $MarginContainer/TextureRect
	texture_rect.texture = texture
#endregion
