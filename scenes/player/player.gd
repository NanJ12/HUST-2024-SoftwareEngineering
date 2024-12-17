#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name Player extends CharacterBody2D

# TODO 玩家 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家 ===============>变 量<===============
#region 变量
# 玩家的激光射线
@onready var ray_cast_2d: RayCast2D = $RayCast2D
# 玩家的激光贴图
@onready var ray_line_2d: Line2D = $RayLine2D
# 玩家的灯光
@onready var point_light_2d: PointLight2D = $Light/PointLight2D
# 玩家的生命模块
@onready var health_model: HealthModel = $HealthModel
# 玩家的体力模块
@onready var strength_model: StrengthModel = $StrengthModel
# 玩家的经验模块
@onready var level_model: LevelModel = $LevelModel
# 玩家的碰撞体
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
# 玩家的图像
@onready var deer_polygon: DeerPolygon = $DeerPolygon
# 玩家的速度
@export var speed : float = 350
# 玩家的跳跃速度
var jump_speed : float
@export var max_jump_speed : float = 500:
	set(v):
		max_jump_speed = v
		_on_global_value_value_update()
# 玩家的冲刺速度
@export var sprint_speed : float = 1200
# 玩家吸附时下落速度
@export var adsop_down_speed : Vector2 = Vector2(0., 2.4)
# 玩家存档点
@export var spawn_pos : Marker2D
# 玩家的方向
var dir : float
# 玩家最后的方向
var last_dir : float
# 玩家跳跃次数
var jump_count : int = 2
# 玩家是否跳跃
var is_jump : bool = false
# 玩家是否滑翔
var is_gliding : bool = false
# 玩家是否吸附
var is_adsorption : bool = false
# 玩家是否死亡
var is_dead : bool = false:
	set(v):
		is_dead = v
		collision_shape_2d.set_deferred("disabled", is_dead)
# 玩家是否冲刺
var is_sprint : bool = false
# 玩家是否能冲刺
var can_sprint : bool = true:
	set(v):
		can_sprint = v
		if not can_sprint:
			sprint_cd = max_sprint_cd
# 玩家是否受伤
var is_hurt : bool = false
# 玩家受伤方向
var hurt_dir : Vector2 = Vector2.ZERO
# 玩家冲刺CD
var max_sprint_cd : float = 3:
	set(v):
		max_sprint_cd = v
		if max_sprint_cd <= .1:
			max_sprint_cd = .1
# 玩家当前冲刺CD
var sprint_cd : float
# 玩家残影出现的CD
var trail_time : float = .06
# 玩家是否能回复光源
var can_heal_light : bool = false
# 玩家是否处于紫光范围
var is_in_purple_light : bool = false
# 玩家是否在交互
var interact : bool = false
# 玩家是否飞行
var is_fly : bool = false
# 玩家重力
var gravity : Vector2
# 玩家漂浮倍率
var gliding_gravity_level : float = 4
# 玩家生命消耗速度
var health_expend_speed : float = .4
# 玩家体力消耗速度
var strength_expend_speed : float = 1
# 玩家是否在雪山范围
var not_in_snowy_mountain : bool = true
# 玩家重置
var is_back_spawn_pos : bool = false
# 玩家重置需要的时间
var back_cd : float = 3:
	set(v):
		back_cd = v
		if back_cd <= 0:
			# 使用 Tween 实现将玩家传送回存档点
			var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_BACK).set_parallel()
			tween.tween_property(self, "scale", Vector2.ZERO, 0.75)
			tween.chain().tween_property(self, "global_position", spawn_pos.global_position, 0.75)
			tween.chain().tween_property(self, "scale", Vector2.ONE, 0.75)
			await tween.finished
			back_cd = 3
# 玩家激光
var ray_shot : bool = false:
	set(v):
		ray_shot = v
		if not ray_body:
			ray_destory_time = 5
# 玩家激光摧毁方块速度
var max_ray_destroy_time : float = 3
var ray_destory_time : float = 3:
	set(v):
		ray_destory_time = v
		if ray_destory_time <= 0:
			ray_destory_time = max_ray_destroy_time * \
				(1 - GlobalValue.ray_destroy_time_level * GlobalValue.RAY_DESTROY_BUFF_RADIO)
			if ray_body:
				ray_body.queue_free()
				ray_body = null

# 玩家的激光碰到的机关
var ray_body : CharacterBody2D:
	set(v):
		ray_body = v
		if ray_body == null:
			gravity = GlobalValue.gravity
# 玩家的 Buff 组
var buffs : Array[BaseBuff]
# 玩家的 颜色策略组
var player_color : PlayerColor:
	set(v):
		player_color = v
		if player_color != null:
			player_color.player_color_effect()
# 玩家在加buff前最大生命值
var max_health : float
# 玩家在加buff前最大体力
var max_strength : float
# 玩家的默认冲刺 cd
var normal_sprint_cd : float = 3.:
	set(v):
		normal_sprint_cd = v
		_on_global_value_value_update()
# 玩家钩索
var is_joit : bool = false:
	set(v):
		is_joit = v
# 玩家是否是轻的
var is_light : bool
# 玩家的额外重力
var ex_gravity : Vector2 = Vector2.ZERO
# 玩家在水晶
var in_the_crystal : bool = false
# 玩家无法跳跃
var cant_jump : bool = false
#endregion

# TODO 玩家 ===============>虚方法<===============
#region 常用的虚方法
func _ready() -> void:
	Global.player = self

	health_model.health_update.connect(_on_health_model_health_update)
	health_model.is_dead.connect(_on_health_model_is_dead)

	if not Global.is_load_save:
		level_model.reset_level()

	ray_line_2d.add_point(ray_cast_2d.global_position)

	GlobalValue.value_update.connect(_on_global_value_value_update)
	GlobalValue.buff_update.connect(_on_global_value_buff_update)

	_on_global_value_value_update()
	gravity = GlobalValue.gravity
	AudioManager.cd_update.connect(_on_audio_manager_cd_update)

	player_color = Global.player_colors[0]


func _process(_delta: float) -> void:
	dir = get_input_dir()

	# 判断 dir 如果非零，记录最后方向
	if not dir == 0:
		last_dir = dir

	if Input.is_action_just_pressed("action_jump") and is_on_floor():
		is_jump = true

	if Input.is_action_just_pressed("action_sprint") and is_on_floor() and can_sprint:
		can_sprint = false
		is_sprint = true

	if Input.is_action_just_pressed("action_interact"):
		interact = true
	elif Input.is_action_just_released("action_interact"):
		interact = false

	is_adsorption = Input.is_action_pressed("action_adsorption")

	is_gliding = Input.is_action_pressed("action_jump")

	is_back_spawn_pos = Input.is_action_pressed("action_back")

	ray_shot = Input.is_action_pressed("mouse_left") and GlobalValue.can_ray_destory

	is_joit = Input.is_action_pressed("mouse_right") and GlobalValue.can_ray_interact

func _physics_process(delta: float) -> void:
	move_and_slide()

	ray_shoot(delta)

	if in_the_crystal:
		health_model.health += delta * 4
		strength_model.strength += delta * 4
	elif can_heal_light:
		health_model.health += delta * 2
		strength_model.strength += delta * 2
	elif is_in_purple_light :
		health_model.health -= delta
	else :
		# 血量减少
		health_model.health -= delta * health_expend_speed

	# 冲刺状态的 CD
	if not can_sprint:
		sprint_cd -= delta * (1 + GlobalValue.continue_sprint_buff_level * GlobalValue.CONTINUE_SPRINT_BUFF_RADIO)
		if sprint_cd <= 0:
			can_sprint = true

	if absf(velocity.x) > 600:
		trail_time -= delta
		if trail_time <= 0:
			trail_time = .06
			var trail = Global.TRAIL.instantiate()

			get_parent().add_child(trail)
			get_parent().move_child(trail, get_index())

			trail.texture = deer_polygon.texture
			trail.global_position = global_position

	# 玩家经验提升
	# WARNING 这里为了测试修改成了10
	if velocity.length() > 0:
		if level_model.level == 50:
			level_model.e_x_p = level_model.max_exp
		else :
			level_model.e_x_p += delta * 3

	# 玩家回城
	if is_back_spawn_pos and back_cd > 0:
		back_cd -= delta
#endregion

# TODO 玩家 ===============>信号链接方法<===============
#region 信号链接方法
# TODO_FUC 玩家：根据血量更新亮度
func _on_health_model_health_update(health: float, _max_health: float) -> void:
	# FIXME 后面记得将这个亮度值 1 修改成一个变量
	point_light_2d.texture_scale = (health / _max_health) * 1

# TODO_FUC 玩家：生命模块：死亡信号
func _on_health_model_is_dead() -> void:
	is_dead = true

# TODO_FUC 玩家：等级模块：升级
func _on_level_model_level_up(level: int) -> void:
	GlobalValue.skill_point += 2
	GlobalValue.player_level = level

# TODO_FUC 玩家：技能属性修改
func _on_global_value_value_update() -> void:
	health_model.max_health = 20 + GlobalValue.player_luminance_level * 10
	max_health = health_model.max_health
	strength_model.max_strength = 50 + GlobalValue.player_strength_level * 15
	max_strength = strength_model.max_strength
	max_sprint_cd = normal_sprint_cd - GlobalValue.player_sprint_cd_level * .4
	jump_speed = max_jump_speed + GlobalValue.player_jump_height_level * 20
	strength_model.strength_recover_speed = .8 + GlobalValue.player_strength_recover_level * .1
	health_expend_speed = .4 - GlobalValue.player_health_expend_level * .04
	strength_expend_speed = 1 - GlobalValue.player_strength_expend_level * .1
	adsop_down_speed = Vector2(0., 1.6 - GlobalValue.player_adsorp_down_level * .14)

# TODO_FUC 玩家：CD 更改信号方法
func _on_audio_manager_cd_update(cd : Array[CD]) -> void:
	buffs = []
	for i in cd.size():
		if cd[i] == null: continue
		var _cd : CD = cd[i]
		buffs.append(_cd.cd_buff)

	for i in buffs:
		i.buff_effect()

# TODO_FUC 玩家：Buff更新信号方法
func _on_global_value_buff_update() -> void:
	health_model.max_health = max_health
	health_model.max_health *= (1 + (GlobalValue.health_buff_level * GlobalValue.HEALTH_BUFF_RADIO))
	strength_model.max_strength = max_strength
	strength_model.max_strength *= (1 + (GlobalValue.abundant_buff_level * GlobalValue.ABUNDANT_BUFF_RADIO))
#endregion

# TODO 玩家 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 玩家：方向获取
func get_input_dir() -> float:
	return Input.get_axis("action_l", "action_r")

# TODO_FUC 玩家：重置属性
func reset_value() -> void:
	velocity = Vector2.ZERO
	dir = 0
	last_dir = 0
	jump_count = 2
	is_jump = false
	is_gliding = false
	is_adsorption  = false
	is_sprint = false
	can_sprint = true
	is_hurt = false
	sprint_cd = 0
	can_heal_light = false

# TODO_FUC 玩家：激光发射
func ray_shoot(delta : float) -> void:
		# 玩家激光发射
	if not ray_cast_2d: return
	if not ray_shot and not is_joit:
		ray_line_2d.clear_points()
		ray_cast_2d.rotation = 0
		ray_destory_time = max_ray_destroy_time * \
			(1 - GlobalValue.ray_destroy_time_level * GlobalValue.RAY_DESTROY_BUFF_RADIO)
		ray_cast_2d.target_position = Vector2.ZERO
		if ray_body:
			ray_body = null
		return

	if is_joit:
		ray_cast_2d.target_position.x = get_global_mouse_position().distance_to(global_position)
		ray_cast_2d.look_at(get_global_mouse_position())
		ray_line_2d.default_color = Color.YELLOW
		ray_line_2d.points = PackedVector2Array([0, get_local_mouse_position()])
	elif ray_shot and not ray_cast_2d.is_colliding():
		ray_cast_2d.target_position.x = lerp(ray_cast_2d.target_position.x ,get_global_mouse_position().distance_to(global_position), .05)
		ray_cast_2d.look_at(get_global_mouse_position())
		ray_line_2d.default_color = Color.HOT_PINK
		ray_line_2d.points = PackedVector2Array([Vector2.ZERO, ray_cast_2d.target_position.rotated(ray_cast_2d.rotation)])

	if not ray_cast_2d.is_colliding():
		gravity = GlobalValue.gravity
		ray_destory_time = max_ray_destroy_time * \
			(1 - GlobalValue.ray_destroy_time_level * GlobalValue.RAY_DESTROY_BUFF_RADIO)
		ray_body = null
		return

	if ray_cast_2d.get_collider() is Organ:
		ray_body = ray_cast_2d.get_collider()

	if is_joit:
		if ray_body is RayPointOrgan:
			gravity = -GlobalValue.gravity
		else :
			ray_body = null

	if ray_shot:
		if ray_body is FragileBlockOrgan:
			if ray_destory_time > 0:
				ray_destory_time -= delta
#endregion
