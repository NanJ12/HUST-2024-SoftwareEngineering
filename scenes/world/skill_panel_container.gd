#--------------------------------------
# 这个类
# 类中自定义了
# 定义了
#--------------------------------------
class_name SkillPanelContainer extends PanelContainer

# TODO 技能树页面 ===============>信 号<===============
#region 信号

#endregion

# TODO 技能树页面 ===============>常 量<===============
#region 常量

#endregion

# TODO 技能树页面 ===============>变 量<===============
#region 变量
# 技能树页面：主动技能按钮
@onready var active_skill: GameButton = $MarginContainer/HBoxContainer/SkillMode/ActiveSkill
# 技能树页面：被动技能按钮
@onready var passive_skill: GameButton = $MarginContainer/HBoxContainer/SkillMode/PassiveSkill
# 技能树页面：重置按钮
@onready var reset_button: GameButton = $MarginContainer/HBoxContainer/SkillTree/ButtonGroup/Reset
# 技能树页面：返回按钮
@onready var return_button: GameButton = $MarginContainer/HBoxContainer/SkillTree/ButtonGroup/Return
# 技能树页面：已加点数
@onready var used_count_num: Label = $MarginContainer/HBoxContainer/SkillMode/Counts/UsedCount/uesd_count_num
# 技能树页面：技能点数
@onready var unuse_count_num: Label = $MarginContainer/HBoxContainer/SkillMode/Counts/UnusedCount/unuse_count_num
# 技能树页面：被动技能面板
@onready var passive_skill_control: Control = %PassiveSkillControl
# 技能树页面：生命上限
@onready var health_game_button: GameButton = %HealthGameButton
# 技能树页面：体力上限
@onready var strength_game_button: GameButton = %StrengthGameButton
# 技能树页面：冲刺 CD
@onready var sprint_cd_game_button: GameButton = %SprintCDGameButton
# 技能树页面：跳跃高度
@onready var jump_height_game_button: GameButton = %JumpHeightGameButton
# 技能树页面：体力恢复速度
@onready var strength_recover_button: GameButton = %StrengthRecoverButton
# 技能树页面：血量消耗降低
@onready var health_expend_game_button: GameButton = %HealthExpendGameButton
# 技能树页面：体力消耗降低
@onready var strength_expend_game_button: GameButton = %StrengthExpendGameButton
# 技能树页面：吸附时下滑速度
@onready var adsorp_down_game_button: GameButton = %AdsorpDownGameButton
# 技能树页面：主动技能面板
@onready var active_skill_control: Control = %ActiveSkillControl
# 技能树页面：空中转体
@onready var air_twist_game_button: GameButton = %AirTwistGameButton
# 技能树页面：二段跳
@onready var double_jump_game_button: GameButton = %DoubleJumpGameButton
# 技能树页面：吸附
@onready var adsorption_game_button: GameButton = %AdsorptionGameButton
# 技能树页面：破坏激光
@onready var destory_ray_game_button: GameButton = %DestoryRayGameButton
# 技能树页面：交互激光
@onready var interact_ray_game_button: GameButton = %InteractRayGameButton
# 技能树页面：初始位置
var current_pos : Vector2
#endregion

# TODO 技能树页面 ===============>虚方法<===============
#region 常用的虚方法
func _init() -> void:
	pass

func _ready() -> void:
	#  链接按钮上的 pressed 信号
	return_button.pressed.connect(_on_return_button_pressed)
	reset_button.pressed.connect(_on_reset_button_pressed)
	passive_skill.pressed.connect(_on_passive_skill_pressed)
	active_skill.pressed.connect(_on_active_skill_pressed)
	health_game_button.pressed.connect(_on_health_game_button_pressed)
	strength_game_button.pressed.connect(_on_strength_game_button_pressed)
	sprint_cd_game_button.pressed.connect(_on_sprint_cd_game_button_pressed)
	jump_height_game_button.pressed.connect(_on_jump_height_button_pressed)
	strength_recover_button.pressed.connect(_on_strength_recover_button_pressed)
	health_expend_game_button.pressed.connect(_on_health_expend_game_button_pressed)
	strength_expend_game_button.pressed.connect(_on_strength_expend_game_button_pressed)
	adsorp_down_game_button.pressed.connect(_on_adsorp_down_game_button)
	air_twist_game_button.pressed.connect(_on_air_twist_game_button_pressed)
	double_jump_game_button.pressed.connect(_on_double_jump_game_button_pressed)
	adsorption_game_button.pressed.connect(_on_adsorption_game_button_pressed)
	destory_ray_game_button.pressed.connect(_on_destory_ray_game_button_pressed)
	interact_ray_game_button.pressed.connect(_on_interact_ray_game_button_pressed)

	if not current_pos:
		current_pos = global_position


func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	reset_button.disabled = not Global.player.in_the_crystal

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_action_pressed("action_skilltree") and not Global.is_command:
			UiTool.hide_all_ui(get_parent(), self)
			visible = true

func _unhandled_input(_event: InputEvent) -> void:
	pass
#endregion

# TODO 技能树页面 ===============>信号链接方法<===============
#region 信号链接方法
# TODO 技能树页面：返回游戏按钮：pressed 信号方法
func _on_return_button_pressed() -> void:
	await GroundGlass.glass_exit()
	await UiTool.ui_exit(self)
	# 关闭技能树窗口
	hide()

## TODO 技能树页面：重置按钮：pressed 信号方法
func _on_reset_button_pressed() -> void:
	if not GlobalValue.has_used_skill_point(): return

	health_game_button.disabled = false
	strength_game_button.disabled = false
	sprint_cd_game_button.disabled = false
	jump_height_game_button.disabled = false
	strength_recover_button.disabled = false
	health_expend_game_button.disabled = false
	strength_expend_game_button.disabled = false
	adsorp_down_game_button.disabled = false
	air_twist_game_button.disabled = false
	double_jump_game_button.disabled = false
	adsorption_game_button.disabled = false
	destory_ray_game_button.disabled = false
	interact_ray_game_button.disabled = false

	health_game_button.get_child(0).text = "0"
	strength_game_button.get_child(0).text = "0"
	sprint_cd_game_button.get_child(0).text = "0"
	jump_height_game_button.get_child(0).text = "0"
	strength_recover_button.get_child(0).text = "0"
	health_expend_game_button.get_child(0).text = "0"
	strength_expend_game_button.get_child(0).text = "0"
	adsorp_down_game_button.get_child(0).text = "0"

	GlobalValue.reset()
	update_skill_point()

## TODO_FUC 技能树页面：被动技按钮：pressed 信号方法
func _on_passive_skill_pressed() -> void:
	active_skill.disabled = false
	passive_skill.disabled = true
	passive_skill_control.show()
	active_skill_control.hide()

## TODO_FUC 技能树页面：主动技按钮：pressed 信号方法
func _on_active_skill_pressed() -> void:
	active_skill.disabled = true
	passive_skill.disabled = false
	passive_skill_control.hide()
	active_skill_control.show()

# TODO_FUC 技能树页面：visible 切换的信号方法
func _on_visibility_changed() -> void:
	if visible:
		self.global_position.y = current_pos.y - 1000
		await GroundGlass.glass_enter()
		await UiTool.ui_enter(self, current_pos)
		update_skill_point()

	# 当显示的时候暂停
	get_tree().paused = true if visible else false

# TODO_FUC 技能树页面：生命上限按钮
func _on_health_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < GlobalValue.player_luminance_level + 1: return

	GlobalValue.skill_point -= GlobalValue.player_luminance_level + 1
	GlobalValue.used_skill_point += GlobalValue.player_luminance_level + 1
	update_skill_point()
	GlobalValue.player_luminance_level += 1
	health_game_button.get_child(0).text = "%s" % GlobalValue.player_luminance_level
	if GlobalValue.player_luminance_level == 5:
		health_game_button.disabled = true

# TODO_FUC 技能树页面：体力上限按钮
func _on_strength_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < GlobalValue.player_strength_level + 1: return

	GlobalValue.skill_point -= GlobalValue.player_strength_level + 1
	GlobalValue.used_skill_point += GlobalValue.player_strength_level + 1
	update_skill_point()
	GlobalValue.player_strength_level += 1
	strength_game_button.get_child(0).text = "%s" % GlobalValue.player_strength_level
	if GlobalValue.player_strength_level == 5:
		strength_game_button.disabled = true

# TODO_FUC 技能树页面：冲刺CD按钮
func _on_sprint_cd_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < GlobalValue.player_sprint_cd_level + 1: return

	GlobalValue.skill_point -= GlobalValue.player_sprint_cd_level + 1
	GlobalValue.used_skill_point += GlobalValue.player_sprint_cd_level + 1
	update_skill_point()
	GlobalValue.player_sprint_cd_level += 1
	sprint_cd_game_button.get_child(0).text = "%s" % GlobalValue.player_sprint_cd_level
	if GlobalValue.player_sprint_cd_level == 5:
		sprint_cd_game_button.disabled = true

# TODO_FUC 技能树页面：跳跃高度按钮
func _on_jump_height_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < GlobalValue.player_jump_height_level + 1: return

	GlobalValue.skill_point -= GlobalValue.player_jump_height_level + 1
	GlobalValue.used_skill_point += GlobalValue.player_jump_height_level + 1
	update_skill_point()
	GlobalValue.player_jump_height_level += 1
	jump_height_game_button.get_child(0).text = "%s" % GlobalValue.player_jump_height_level
	if GlobalValue.player_jump_height_level == 5:
		jump_height_game_button.disabled = true


# TODO_FUC 技能树页面：体力恢复速度按钮
func _on_strength_recover_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < GlobalValue.player_strength_recover_level + 1: return

	GlobalValue.skill_point -= GlobalValue.player_strength_recover_level + 1
	GlobalValue.used_skill_point += GlobalValue.player_strength_recover_level + 1
	update_skill_point()
	GlobalValue.player_strength_recover_level += 1
	strength_recover_button.get_child(0).text = "%s" % GlobalValue.player_strength_recover_level
	if GlobalValue.player_strength_recover_level == 5:
		strength_recover_button.disabled = true

# TODO_FUC 技能树页面：生命消耗速度按钮
func _on_health_expend_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < GlobalValue.player_health_expend_level + 1: return

	GlobalValue.skill_point -= GlobalValue.player_health_expend_level + 1
	GlobalValue.used_skill_point += GlobalValue.player_health_expend_level + 1
	update_skill_point()
	GlobalValue.player_health_expend_level += 1
	health_expend_game_button.get_child(0).text = "%s" % GlobalValue.player_health_expend_level
	if GlobalValue.player_health_expend_level == 5:
		health_expend_game_button.disabled = true

# TODO_FUC 技能树页面：体力消耗速度按钮
func _on_strength_expend_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < GlobalValue.player_strength_expend_level + 1: return

	GlobalValue.skill_point -= GlobalValue.player_strength_expend_level + 1
	GlobalValue.used_skill_point += GlobalValue.player_strength_expend_level + 1
	update_skill_point()
	GlobalValue.player_strength_expend_level += 1
	strength_expend_game_button.get_child(0).text = "%s" % GlobalValue.player_strength_expend_level
	if GlobalValue.player_strength_expend_level == 5:
		strength_expend_game_button.disabled = true

# TODO_FUC 技能树页面：吸附下滑速度按钮
func _on_adsorp_down_game_button() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < GlobalValue.player_adsorp_down_level + 1: return

	GlobalValue.skill_point -= GlobalValue.player_adsorp_down_level + 1
	GlobalValue.used_skill_point += GlobalValue.player_adsorp_down_level + 1
	update_skill_point()
	GlobalValue.player_adsorp_down_level += 1
	adsorp_down_game_button.get_child(0).text = "%s" % GlobalValue.player_adsorp_down_level
	if GlobalValue.player_adsorp_down_level == 5:
		adsorp_down_game_button.disabled = true

# TODO_FUC 技能树页面：空中转体按钮
func _on_air_twist_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < 5: return

	GlobalValue.skill_point -= 5
	GlobalValue.used_skill_point += 5
	update_skill_point()
	GlobalValue.can_air_twist = true
	if GlobalValue.can_air_twist:
		air_twist_game_button.disabled = true

# TODO_FUC 技能树页面：二段跳按钮
func _on_double_jump_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < 5: return

	GlobalValue.skill_point -= 5
	GlobalValue.used_skill_point += 5
	update_skill_point()
	GlobalValue.can_double_jump = true
	if GlobalValue.can_double_jump:
		double_jump_game_button.disabled = true

# TODO_FUC 技能树页面：吸附按钮
func _on_adsorption_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < 5: return

	GlobalValue.skill_point -= 5
	GlobalValue.used_skill_point += 5
	update_skill_point()
	GlobalValue.can_adsorption_jump = true
	if GlobalValue.can_adsorption_jump:
		adsorption_game_button.disabled = true

# TODO_FUC 技能树页面：破坏激光
func _on_destory_ray_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < 5: return

	GlobalValue.skill_point -= 5
	GlobalValue.used_skill_point += 5
	update_skill_point()
	GlobalValue.can_ray_destory = true
	if GlobalValue.can_ray_destory:
		destory_ray_game_button.disabled = true

# TODO_FUC 技能树页面：交互激光
func _on_interact_ray_game_button_pressed() -> void:
	if not GlobalValue.has_skill_point(): return
	if GlobalValue.skill_point < 5: return

	GlobalValue.skill_point -= 5
	GlobalValue.used_skill_point += 5
	update_skill_point()
	GlobalValue.can_ray_interact = true
	if GlobalValue.can_ray_interact:
		interact_ray_game_button.disabled = true
#endregion

# TODO 技能树页面 ===============>工具方法<===============
#region 工具方法
## TODO_FUC 技能树页面：隐藏方法
func _hide() -> void:
	await UiTool.ui_exit(self)
	# 关闭暂停窗口
	hide()

# TODO_FUC 技能树页面：技能点更新
func update_skill_point() -> void:
	unuse_count_num.text = "%s" % GlobalValue.skill_point
	used_count_num.text = "%s" % GlobalValue.used_skill_point
#endregion
