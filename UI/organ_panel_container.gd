#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name OrganPanelContainer extends PanelContainer

# TODO name ===============>信 号<===============
#region 信号
signal chick_organ_slot(index : int)
#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
var texture_rect: TextureRect
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

#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
func set_organ_panel(_text : String, texture : Texture2D) -> void:
	texture_rect = $MarginContainer/TextureRect
	texture_rect.texture = texture
	tooltip_text = _text
#endregion


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("mouse_left"):
			chick_organ_slot.emit(get_index())
