class_name Save extends Resource
# 玩家激活的传送点
@export var spawn_points : Dictionary

# 玩家位置
@export var player_position : Vector2

# 玩家存档点位置
@export var player_spawn_pos : Vector2

# 玩家CD
@export var has_cd : Array[CD]
@export var cd : Array[CD] = [null, null, null, null]

# 玩家颜色
@export var player_color : PlayerColor

# 定义全局重力
@export var gravity : Vector2

# 剧情碎片
@export var memory_fragments : Array[MemoryFragment]

# 红色对话
@export var red_dialogic_enabled : bool

# 追逐战
@export var is_war_of_pursuit : bool

# 邪恶lumine准备攻击
@export var evil_lumine_is_relly_attack : bool

# 跳跃教程
@export var learning_jumping : bool

# 漂浮教程
@export var learning_gliding : bool

# 冲刺教程
@export var learning_sprinting : bool

# 全局属性：技能点
@export var skill_point : int

# 全局属性：已使用技能点
@export var used_skill_point : int

# 全局属性：玩家等级
@export var player_level : int

# 属性：玩家经验
@export var e_x_p : float

# 全局属性：玩家亮度
@export var player_luminance_level : int

# 全局属性：玩家体力
@export var player_strength_level : int

# 全局属性：玩家冲刺
@export var player_sprint_cd_level : int

# 全局属性：玩家跳跃高度
@export var player_jump_height_level : int

# 全局属性：玩家体力回复
@export var player_strength_recover_level : int

# 全局属性：玩家血量降低
@export var player_health_expend_level : int

# 全局属性：玩家体力降低
@export var player_strength_expend_level : int

# 全局属性：玩家吸附下滑速度
@export var player_adsorp_down_level : int

# 全局属性：玩家空中转体
@export var can_air_twist : bool

# 全局属性：玩家二段跳
@export var can_double_jump : bool

# 全局属性：玩家吸附
@export var can_adsorption_jump : bool

# 全局属性：玩家交互激光
@export var can_ray_interact : bool

# 全局属性：玩家破坏激光
@export var can_ray_destory : bool

# 全局属性：亮度提升Buff
@export var health_buff_level : int

# 全局属性：冲刺距离Buff
@export var sprint_buff_level : int

# 全局属性：充沛Buff
@export var abundant_buff_level : int

# 全局属性：连冲Buff
@export var continue_sprint_buff_level : int

# 全局属性：羽落Buff
@export var feather_fall_buff_level : int

# 全局属性：强电buff
@export var ray_destroy_time_level : int
