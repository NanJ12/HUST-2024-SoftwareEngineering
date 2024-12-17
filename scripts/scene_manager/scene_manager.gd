# TODO 场景管理器
extends CanvasLayer

# TODO 场景管理器 ===============>信 号<===============
#region 信号

#endregion

# TODO 场景管理器 ===============>常 量<===============
#region 常量
# TODO_ENUM 场景管理器：场景的索引
enum SCENE_INDEX{
	MAIN,
	WORLD
}
#endregion

# TODO 场景管理器 ===============>变 量<===============
#region 变量
## 动画器获取
@onready var animation_player: AnimationPlayer = $AnimationPlayer
## 颜色遮罩获取
@onready var color_rect: ColorRect = $ColorRect

## 场景集合
@export var scenes : Array[PackedScene]

var current_scene_index : SCENE_INDEX = SCENE_INDEX.MAIN
#endregion

# TODO 场景管理器 ===============>信号链接方法<===============
#region 信号链接方法

#endregion

# TODO 场景管理器 ===============>工具方法<===============
#region 工具方法
# TODO_FUC 场景管理器：场景切换的方法
func scene_switch(scene_index, shader_index) -> void:
	color_rect.material.set_shader_parameter("mode", shader_index)
	animation_player.play("tran_in")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(scenes[scene_index])
	animation_player.play("tran_out")
	current_scene_index = scene_index
#endregion
