extends State

# TODO 玩家：状态：冲刺 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：冲刺 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：冲刺 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."
var trail_time : float = .1
#endregion

# TODO 玩家：状态：冲刺 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("==========> 玩家进入冲刺")
	player.velocity = \
		Vector2(
			(player.last_dir * player.sprint_speed) * (1 + GlobalValue.sprint_buff_level * GlobalValue.SPRINT_BUFF_RADIO)
			, 0
		).rotated(player.ray_cast_2d.rotation)
	if player.ray_cast_2d.rotation == 0:
		player.strength_model.strength -= 2 * player.strength_expend_speed
	else :
		player.strength_model.strength -= 10 * player.strength_expend_speed
	AudioManager.sfx_play(2)

func update(_delta : float):
	if player.is_hurt: update_state.emit("Hurt")

	if absf(player.velocity.x) < absf(player.last_dir * player.speed * 2): update_state.emit("Idle")
	if absf(player.velocity.x) < 500: update_state.emit("Idle")

func physics_update(_delta : float):
	player.velocity.x = lerp(player.velocity.x, player.last_dir * player.speed, .1)

func exit():
	player.is_sprint = false
#endregion

# TODO 玩家：状态：冲刺 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：冲刺 ===============>工具方法<===============
#region 工具方法

#endregion
