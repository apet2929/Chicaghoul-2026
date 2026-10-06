extends DialogueManager

func show_title_card():
	%RocketCam.current = true
	%RocketCam/TitleCard.visible = true
	%Clouds.visible = true
	var subs = %Subtitles
	subs.get_parent().remove_child(subs)
	%RocketCam.add_child(subs)
	
