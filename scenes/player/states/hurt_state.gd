extends State

# TODO 状态：受伤 ===============>信 号<===============
#region 信号

#endregion

# TODO 状态：受伤 ===============>常 量<===============
#region 常量

#endregion

# TODO 状态：受伤 ===============>变 量<===============
#region 变量
@onready var player: Player = $"../.."

#endregion

# TODO 状态：受伤 ===============>状态模板方法<===============
#region 状态模板方法
func enter():
	UiTool.fly_text(player.global_position + Vector2(0, -96), "玩家进入受伤", 1.5, 24, Color.RED)
	if player.speed == 0 or player.jump_speed == 0:
		player.velocity = Vector2(player.speed, player.jump_speed / 2) * player.hurt_dir
	else :
		player.velocity = Vector2(300, 200) * player.hurt_dir

	AudioManager.sfx_play(0)

	var camera : Camera = get_viewport().get_camera_2d()
	camera.shake_camera(.3, 10)


func update(_delta : float):
	if not player.is_hurt:
		update_state.emit("Idle")

func physics_update(_delta : float):
	player.velocity += (player.gravity + player.ex_gravity)
	player.velocity.x = lerp(player.velocity.x, 0., .1)

func exit():
	player.jump_speed = absf(player.jump_speed)
#endregion

# TODO 状态：受伤 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 状态：受伤 ===============>工具方法<===============
#region 工具方法

#endregion
