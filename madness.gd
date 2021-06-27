extends Spatial

onready var audio = $chicken
onready var grunt_anim = $stuff/grunt/AnimationPlayer
onready var rect = $rect
onready var time = $Timer
onready var boomboxer = $stuff/boombox/AnimationPlayer

var oneshot : bool = false
var fadeback : bool = false

func val_norm(val : float):
	return clamp(val, 0.0, 1.0)

func _process(delta):
	if(oneshot and rect.color.a > 0.0):
		rect.color.a = val_norm(rect.color.a - (delta * 4))
	if(fadeback and rect.color.a < 1.0):
		rect.color.a = val_norm(rect.color.a + (delta * 0.5))
	if(!oneshot and fadeback and rect.color.a == 1.0):
		fadeback = false
	
	if(Input.is_action_just_pressed("commence") and !oneshot and !fadeback):
		grunt_anim.play("ArmatureAction")
		audio.play()
		boomboxer.play("anim-loop")
		time.start()
		oneshot = true

func _on_Timer_timeout():
	fadeback = true
	oneshot = false
