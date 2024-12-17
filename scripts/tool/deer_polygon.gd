@tool
class_name DeerPolygon extends Polygon2D

# TODO 多边形生成器 ===============>信 号<===============
#region 信号

#endregion

# TODO 多边形生成器 ===============>常 量<===============
#region 常量

#endregion

# TODO 多边形生成器 ===============>变 量<===============
#region 变量
# 多边形的边
@export var polygon_edge : int = 3:
	set(v):
		polygon_edge = v
		if polygon_edge < 3:
			polygon_edge = 3
			push_error("多边形必须有三条边")
		create_polygon()
# 多边形的边长
@export var polygon_length : float = 32:
	set(v):
		polygon_length = v
		if polygon_length <= 0:
			polygon_length = .01
			push_error("多边形的变长不能为0")
		create_polygon()
# 文本
@export var text : String
#endregion

# TODO 多边形生成器 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	create_polygon()

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func _input(_event: InputEvent) -> void:
	pass

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 多边形生成器 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 多边形生成器 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 多边形生成器：多边形创建方法
func create_polygon() -> void:
	# 将角度转化为弧度
	var polygon_rad : float = deg_to_rad(360. / polygon_edge)
	# 临时点变量
	var point : Vector2
	# 临时点集合
	var points : Array[Vector2] = []

	# 使用for循环进行点的创建
	for point_index in polygon_edge:
		# 根据上一个点的坐标和弧度创建下一个点
		point.x = cos(point_index * polygon_rad) * polygon_length
		point.y = sin(point_index * polygon_rad) * polygon_length
		points.append(point)

	# 将临时点集合的数据赋值给多边形数组中
	polygon = points

	if not get_parent(): return

	for i in get_parent().get_children():
		# 使用卫语法判断父级是否是一个多边形碰撞体，不是就跳过
		if i is CollisionPolygon2D:
			# 如果没被卫语法排除，就把父级的多边形碰撞体的多边形数组与当前多边形同步
			i.polygon = polygon
#endregion
