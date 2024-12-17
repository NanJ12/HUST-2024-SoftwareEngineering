#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
@tool
class_name EnergyBundleOrgan extends Organ

# TODO 能量束 ===============>信 号<===============
#region 信号

#endregion

# TODO 能量束 ===============>常 量<===============
#region 常量

#endregion

# TODO 能量束 ===============>变 量<===============
#region 变量
# 第一条射线
@onready var frist_ray_cast_2d: RayCast2D = $FristRayCast2D
# 第二条射线
@onready var second_ray_cast_2d: RayCast2D = $SecondRayCast2D

# 第一射线的目标点
@export var frist_pos : Vector2:
	set(v):
		frist_pos = v
		if frist_ray_cast_2d:
			frist_ray_cast_2d.target_position = frist_pos
# 第二个射线的目标点
@export var second_pos : Vector2:
	set(v):
		second_pos = v
		if second_ray_cast_2d:
			second_ray_cast_2d.target_position = second_pos

var frist_organ : Organ
var second_organ : Organ
#endregion

# TODO 能量束 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	frist_ray_cast_2d.target_position = frist_pos
	second_ray_cast_2d.target_position = second_pos

	await get_tree().process_frame
	frist_organ = frist_ray_cast_2d.get_collider()
	second_organ = second_ray_cast_2d.get_collider()

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	if frist_organ and second_organ:
		if frist_organ is PressurePlateOrgan:
			if second_organ is not MovableBlockOrgan or second_organ is not  RollingStonesOrgan:
				frist_organ.target_trigger_organs.append(second_organ)
		elif second_organ is PressurePlateOrgan:
			if second_organ is not MovableBlockOrgan or second_organ is not  RollingStonesOrgan:
				second_organ.target_trigger_organs.append(frist_organ)


func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 能量束 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 能量束 ===============>工具方法<===============
#region 工具方法

#endregion


func _on_timer_timeout() -> void:
	queue_free()
