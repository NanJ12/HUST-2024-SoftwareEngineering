#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
@tool
class_name CDProp extends Prop

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量
@export var cd : CD:
	set(v):
		cd = v
		if cd:
			if sprite_2d:
				sprite_2d.texture = cd.cd_texture
			else :
				sprite_2d = $Sprite2D
				sprite_2d.texture = cd.cd_texture
@onready var sprite_2d: Sprite2D = $Sprite2D
#endregion

# TODO name ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	sprite_2d.texture = cd.cd_texture

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
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		AudioManager.has_cd.append(cd)
		queue_free()
#endregion

# TODO name ===============>工具方法<===============
#region 工具方法

#endregion
