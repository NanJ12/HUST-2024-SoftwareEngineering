extends Node

# TODO name ===============>信 号<===============
#region 信号

#endregion

# TODO name ===============>常 量<===============
#region 常量

#endregion

# TODO name ===============>变 量<===============
#region 变量

#endregion

# TODO name ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO name ===============>工具方法<===============
#region 工具方法
func parse(command_str : String) -> Command:
	var command_parts : PackedStringArray = command_str.split(" ")
	var command_name : String = command_parts[0]
	var command_property : String = command_parts[1]
	var command_value : float = 0
	var command_value_2 : float = 0
	if command_parts.size() > 2 and command_parts[2].is_valid_float():
		command_value = float(command_parts[2])
	if command_parts.size() > 3 and command_parts[2].is_valid_float():
		command_value_2 = float(command_parts[3])

	if command_name == "player":
		var player = get_tree().get_first_node_in_group("Player")
		if command_property == "home":
			return PlayerCommand.TPCommand.new(player, Vector2(-310, 350))
		elif command_property == "health" and command_parts.size() > 2:
			return PlayerCommand.HealthCommand.new(player, command_value)
		elif command_property == "strength" and command_parts.size() > 2:
			return PlayerCommand.StrengthCommand.new(player, command_value)
		elif command_property == "speed" and command_parts.size() > 2:
			return PlayerCommand.SpeedCommand.new(player, command_value)
		elif command_property == "jump_speed" and command_parts.size() > 2:
			return PlayerCommand.JumpSpeedCommand.new(player, command_value)
		elif command_property == "tp" and command_parts.size() > 3:
			return PlayerCommand.TPCommand.new(player, Vector2(command_value, command_value_2))
		else :
			return null
	elif command_name == "create":
		var player = get_tree().get_first_node_in_group("Player")
		if command_property == "movable_block":
			return CreateCommand.MovableBlockCommand.new(player, command_value)
		elif command_property == "rolling_stone":
			return CreateCommand.RollingStoneCommand.new(player, command_value)
		elif command_property == "ray_light":
			return CreateCommand.RayLightCommand.new(player, command_value)
		else :
			return null
	else :
		return null
#endregion
