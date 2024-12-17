extends State

# TODO 玩家：状态：滑翔 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：滑翔 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：滑翔 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."

#endregion

# TODO 玩家：状态：滑翔 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("==========> 玩家进入滑翔")

func update(_delta : float):
	if player.is_hurt: update_state.emit("Hurt")

	if player.is_dead: update_state.emit("Dead")

	if not player.is_gliding or player.strength_model.strength == 0: update_state.emit("Fall")

	if player.is_on_floor(): update_state.emit("Idle")

func physics_update(_delta : float):
	# 玩家的下落速度等于，（玩家重力 + 玩家额外重力） / 玩家下落倍率 * （1 - 玩家羽落等级 * 玩家羽落倍率）
	player.velocity += \
		((player.gravity + player.ex_gravity) / player.gliding_gravity_level) *\
		(1 - GlobalValue.feather_fall_buff_level * GlobalValue.FEATHER_FALL_BUFF_RADIO)

	player.strength_model.strength -= _delta * 2 * player.strength_expend_speed

	if player.dir and GlobalValue.can_air_twist:
		player.velocity.x = lerp(player.velocity.x, player.dir * player.speed, .1)

func exit():
	pass
#endregion

# TODO 玩家：状态：滑翔 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：滑翔 ===============>工具方法<===============
#region 工具方法

#endregion
