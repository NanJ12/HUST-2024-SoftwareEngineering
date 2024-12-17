extends State

# TODO 玩家：状态：下落 ===============>信 号<===============
#region 信号

#endregion

# TODO 玩家：状态：下落 ===============>常 量<===============
#region 常量

#endregion

# TODO 玩家：状态：下落 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."

#endregion

# TODO 玩家：状态：下落 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	print("===========> 玩家进入下落")

func update(_delta : float):
	if player.is_dead: update_state.emit("Dead")

	if \
	player.is_on_wall_only() and \
	player.is_adsorption and \
	player.jump_count > 0 and \
	player.strength_model.strength > 0 and\
	GlobalValue.can_adsorption_jump and \
	not player.is_fly:
		update_state.emit("Adsorption")

	if \
	player.jump_count > 0 and \
	Input.is_action_just_pressed("action_jump") and \
	player.strength_model.strength > 0 and\
	GlobalValue.can_double_jump and\
	not player.cant_jump and \
	not player.is_fly:
		update_state.emit("DoubleJump")

	if \
	player.is_gliding and \
	player.jump_count > 0 and \
	player.strength_model.strength > 0 and \
	not player.is_fly:
		update_state.emit("Gliding")

	if player.is_on_floor(): update_state.emit("Idle")

func physics_update(_delta : float):
	player.velocity += (player.gravity + player.ex_gravity)

	if player.dir and GlobalValue.can_air_twist:
		player.velocity.x = lerp(player.velocity.x, player.dir * player.speed, .1)

func exit():
	player.is_jump = false
#endregion

# TODO 玩家：状态：下落 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 玩家：状态：下落 ===============>工具方法<===============
#region 工具方法

#endregion
