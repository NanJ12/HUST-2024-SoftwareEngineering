extends State

# TODO 玩家：状态：吸附 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：吸附 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：吸附 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."

#endregion

# TODO 玩家：状态：吸附 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("==========> 玩家进入吸附")
	player.velocity = Vector2.ZERO

func update(_delta : float):
	if player.is_hurt: update_state.emit("Hurt")

	if player.is_dead: update_state.emit("Dead")

	if \
	not player.is_adsorption or \
	not player.is_on_wall() or \
	player.strength_model.strength == 0:
		update_state.emit("Fall")

	if player.is_on_floor(): update_state.emit("Idle")

	if \
	player.is_gliding and \
	player.jump_count > 0 and \
	player.strength_model.strength > 0:
		update_state.emit("AdsorptionJump")

func physics_update(_delta : float):
	player.velocity += player.adsop_down_speed
	player.strength_model.strength -= _delta * player.strength_expend_speed

func exit():
	player.velocity = Vector2.ZERO
#endregion

# TODO 玩家：状态：吸附 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：吸附 ===============>工具方法<===============
#region 工具方法

#endregion
