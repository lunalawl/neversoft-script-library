winport_gfx_device_num = 0
winport_gfx_text_color = [
	255
	255
	255
	255
]
winport_gfx_text_dropshadow_color = [
	0
	0
	0
	255
]
winport_gfx_text_highlight_color = [
	230
	171
	60
	255
]
winport_gfx_menuItems = [
	{
		text = "Resolution"
		handler = winport_gfx_option_handler
		option = 0
		needRestart = 1
	}
	{
		text = "Graphics Detail"
		handler = winport_gfx_option_handler
		option = 1
		needRestart = 1
		choices = [
			"Low"
			"High"
		]
	}
	{
		text = "Crowd"
		handler = winport_gfx_option_handler
		option = 2
		needRestart = 0
		choices = [
			"Empty"
			"Normal"
			"Packed"
		]
	}
	{
		text = "Physics"
		handler = winport_gfx_option_handler
		option = 3
		needRestart = 0
		choices = [
			"Off"
			"On"
		]
	}
	{
	}
	{
		text = "Reset to Defaults"
		handler = winport_gfx_reset_handler
	}
]
winport_gfx_values_old = [
	0
	0
	0
	0
]
winport_gfx_values_new = [
]
winport_gfx_need_restart = 0

script winport_gfx_get_choices 
	if StructureContains structure = ($winport_gfx_menuItems [<i>]) Name = choices
		return choices = (($winport_gfx_menuItems [<i>]).choices)
	else
		WinPortGfxGetOptionChoices option = (($winport_gfx_menuItems [<i>]).option)
		return choices = <choices>
	endif
endscript

script winport_gfx_set_value 
	SetArrayElement ArrayName = winport_gfx_values_new globalarray index = <i> NewValue = <v>
endscript

script winport_gfx_load_values 
	GetArraySize \{$winport_gfx_values_old}
	valueCount = <array_Size>
	i = 0
	begin
	if StructureContains structure = ($winport_gfx_menuItems [<i>]) Name = option
		WinPortGfxGetOptionValue option = (($winport_gfx_menuItems [<i>]).option)
		SetArrayElement ArrayName = winport_gfx_values_old globalarray index = <i> NewValue = <value>
	endif
	i = (<i> + 1)
	repeat <valueCount>
	Change \{winport_gfx_values_new = $winport_gfx_values_old}
	Change \{winport_gfx_need_restart = 0}
endscript

script winport_gfx_save_values 
	GetArraySize \{$winport_gfx_values_new}
	valueCount = <array_Size>
	i = 0
	begin
	if StructureContains structure = ($winport_gfx_menuItems [<i>]) Name = option
		WinPortGfxSetOptionValue option = (($winport_gfx_menuItems [<i>]).option) value = ($winport_gfx_values_new [<i>])
	endif
	if ((($winport_gfx_menuItems [<i>]).needRestart) = 1)
		if NOT (($winport_gfx_values_new [<i>]) = ($winport_gfx_values_old [<i>]))
			Change \{winport_gfx_need_restart = 1}
		endif
	endif
	i = (<i> + 1)
	repeat <valueCount>
	Change \{winport_gfx_values_old = $winport_gfx_values_new}
	WinPortGfxApplyOptions
	destroy_bg_viewport
endscript

script winport_gfx_reset_values 
	GetArraySize \{$winport_gfx_values_new}
	valueCount = <array_Size>
	i = 0
	begin
	if StructureContains structure = ($winport_gfx_menuItems [<i>]) Name = option
		WinPortGfxGetDefaultOptionValue option = (($winport_gfx_menuItems [<i>]).option)
		SetArrayElement ArrayName = winport_gfx_values_new globalarray index = <i> NewValue = <value>
	endif
	i = (<i> + 1)
	repeat <valueCount>
endscript

script winport_create_gfx_settings_menu 
	menuDim = (600.0, 500.0)
	menuPos = (640.0, 350.0)
	menuItemDim = (600.0, 40.0)
	menuItemOptionDim = (250.0, 40.0)
	menuItemOptionPos = (0.0, 20.0)
	menuItemOptionJust = [left center]
	menuItemValueDim = (250.0, 40.0)
	menuItemValuePos = (600.0, 20.0)
	menuItemValueJust = [right center]
	menuItemHiliteDim = (650.0, 60.0)
	menuItemHilitePos = (-25.0, 34.0)
	menuItemHiliteJust = [left center]
	menuItemHiliteRot = -0.5
	CreateScreenElement \{Type = ContainerElement
		parent = root_window
		id = screen_container
		Pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	create_menu_backdrop \{texture = Venue_BG}
	CreateScreenElement \{Type = SpriteElement
		id = light_overlay
		parent = screen_container
		texture = Venue_Overlay
		Pos = (640.0, 360.0)
		dims = (1280.0, 720.0)
		just = [
			center
			center
		]
		z_priority = 100}
	displaySprite \{parent = screen_container
		tex = graphics_options_poster_part1
		Pos = (640.0, 360.0)
		Scale = (1.6, 1.7)
		just = [
			center
			center
		]
		z = 1
		rot_angle = 2}
	displaySprite \{parent = screen_container
		tex = graphics_options_poster_part2
		Pos = (640.0, 360.0)
		Scale = (1.6, 1.7)
		just = [
			center
			center
		]
		z = 2
		rot_angle = 2}
	displaySprite \{parent = screen_container
		tex = graphics_options_poster_part3
		Pos = (640.0, 360.0)
		Scale = (1.6, 1.7)
		just = [
			center
			center
		]
		z = 3
		rot_angle = 2}
	CreateScreenElement \{Type = TextElement
		parent = screen_container
		text = "GRAPHICS"
		Pos = (837.0, 180.0)
		Scale = (1.8, 1.6800001)
		just = [
			center
			center
		]
		rgba = [
			50
			0
			0
			255
		]
		font = text_a5
		z_priority = 10
		rot_angle = 6
		Shadow
		shadow_rgba = [
			160
			130
			105
			255
		]
		shadow_offs = (-3.0, 3.0)}
	displaySprite \{parent = screen_container
		tex = Tape_V_01
		Pos = (1070.0, 330.0)
		dims = (96.0, 192.0)
		z = 5
		rot_angle = 190}
	displaySprite \{parent = screen_container
		tex = Tape_V_01
		rgba = [
			0
			0
			0
			128
		]
		Pos = (1067.0, 333.0)
		dims = (96.0, 192.0)
		z = 5
		rot_angle = 190}
	displaySprite \{parent = screen_container
		tex = tape_H_02
		Pos = (190.0, 475.0)
		dims = (127.0, 64.0)
		z = 5
		rot_angle = -4}
	displaySprite \{parent = screen_container
		tex = tape_H_02
		rgba = [
			0
			0
			0
			128
		]
		Pos = (187.0, 478.0)
		dims = (127.0, 64.0)
		z = 5
		rot_angle = -4}
	CreateScreenElement {
		Type = VMenu
		id = menu
		parent = screen_container
		Pos = <menuPos>
		dims = <menuDim>
		just = [center center]
		rot_angle = 2
		exclusive_device = ($primary_controller)
		event_handlers = [
			{pad_up generic_menu_up_or_down_sound params = {up}}
			{pad_down generic_menu_up_or_down_sound params = {down}}
			{pad_back winport_gfx_back_handler}
		]
	}
	menuTextProps = {
		Type = TextElement
		font = text_a4
		Scale = 0.7
		rgba = $winport_gfx_text_color
		z_priority = 20
		Shadow
		shadow_rgba = $winport_gfx_text_dropshadow_color
		shadow_offs = (-1.5, 1.5)
	}
	GetArraySize \{$winport_gfx_menuItems}
	menuItemCount = <array_Size>
	i = 0
	begin
	formatText checksumName = itemId 'item%i' i = <i>
	formatText checksumName = optionId 'option%i' i = <i>
	formatText checksumName = valueId 'value%i' i = <i>
	formatText checksumName = hiliteId 'hilite%i' i = <i>
	CreateScreenElement {
		Type = ContainerElement
		id = <itemId>
		parent = menu
		dims = <menuItemDim>
	}
	if StructureContains structure = ($winport_gfx_menuItems [<i>]) Name = text
		SetScreenElementProps {
			id = <itemId>
			event_handlers = [
				{pad_choose (($winport_gfx_menuItems [<i>]).handler) params = {i = <i>}}
				{focus winport_gfx_focus_handler params = {i = <i>}}
				{unfocus winport_gfx_unfocus_handler params = {i = <i>}}
			]
		}
		CreateScreenElement {
			Type = SpriteElement
			id = <hiliteId>
			parent = <itemId>
			texture = graphics_options_highlight
			Pos = <menuItemHilitePos>
			dims = <menuItemHiliteDim>
			rot_angle = <menuItemHiliteRot>
			just = <menuItemHiliteJust>
			alpha = 0
			z_priority = 1.5
			<mode_disable>
		}
		CreateScreenElement {
			<menuTextProps>
			id = <optionId>
			text = (($winport_gfx_menuItems [<i>]).text)
			parent = <itemId>
			dims = <menuItemOptionDim>
			Pos = <menuItemOptionPos>
			just = <menuItemOptionJust>
			<mode_disable>
		}
		if StructureContains structure = ($winport_gfx_menuItems [<i>]) Name = option
			CreateScreenElement {
				<menuTextProps>
				id = <valueId>
				text = "Value"
				parent = <itemId>
				dims = <menuItemValueDim>
				Pos = <menuItemValuePos>
				just = <menuItemValueJust>
				<mode_disable>
			}
			if (<i> = 1)
				if (WinPortIsSM2Card)
					SetScreenElementProps id = <itemId> not_focusable
					SetScreenElementProps id = <optionId> rgba = [80 80 80 255]
					SetScreenElementProps id = <valueId> rgba = [80 80 80 255]
				endif
			endif
			formatText checksumName = choiceMenuId 'choiceMenu%i' i = <i>
			CreateScreenElement {
				Type = VMenu
				id = <choiceMenuId>
				parent = <itemId>
				event_handlers = [
					{pad_up generic_menu_up_or_down_sound params = {up}}
					{pad_down generic_menu_up_or_down_sound params = {down}}
					{pad_back winport_gfx_choice_end_handler params = {i = <i>}}
					{pad_choose winport_gfx_choice_end_handler params = {i = <i>}}
				]
			}
			winport_gfx_get_choices i = <i>
			GetArraySize <choices>
			choiceCount = <array_Size>
			c = 0
			begin
			formatText checksumName = choiceItemId 'choiceItem%i_%c' i = <i> c = <c>
			CreateScreenElement {
				<menuTextProps>
				id = <choiceItemId>
				parent = <choiceMenuId>
				event_handlers = [
					{focus winport_gfx_choice_focus_handler params = {i = <i> c = <c>}}
				]
				<mode_disable>
			}
			c = (<c> + 1)
			repeat <choiceCount>
		endif
	else
		SetScreenElementProps id = <itemId> not_focusable
	endif
	i = (<i> + 1)
	repeat <menuItemCount>
	winport_gfx_load_values
	winport_gfx_update_value_items
	LaunchEvent \{Type = focus
		target = menu}
	Change \{user_control_pill_text_color = [
			0
			0
			0
			255
		]}
	Change \{user_control_pill_color = [
			180
			180
			180
			255
		]}
	add_user_control_helper \{text = "SELECT"
		button = green
		z = 100}
	add_user_control_helper \{text = "BACK"
		button = red
		z = 100}
	add_user_control_helper \{text = "UP/DOWN"
		button = strumbar
		z = 100}
endscript

script winport_destroy_gfx_settings_menu 
	destroy_menu_backdrop
	DestroyScreenElement \{id = screen_container}
	clean_up_user_control_helpers
endscript

script winport_gfx_back_handler 
	winport_gfx_save_values
	if ($winport_gfx_need_restart = 1)
		ui_flow_manager_respond_to_action \{action = need_restart}
	else
		ui_flow_manager_respond_to_action \{action = go_back}
	endif
endscript

script winport_gfx_update_value_items 
	GetArraySize \{$winport_gfx_menuItems}
	menuItemCount = <array_Size>
	i = 0
	begin
	if StructureContains structure = ($winport_gfx_menuItems [<i>]) Name = option
		winport_gfx_get_choices i = <i>
		formatText checksumName = valueId 'value%i' i = <i>
		SetScreenElementProps id = <valueId> text = (<choices> [($winport_gfx_values_new [<i>])])
	endif
	i = (<i> + 1)
	repeat <menuItemCount>
endscript

script winport_gfx_reset_handler 
	winport_gfx_reset_values
	winport_gfx_update_value_items
endscript

script winport_gfx_choice_focus_handler 
	winport_gfx_set_value i = <i> v = <c>
	winport_gfx_update_value_items
endscript

script winport_gfx_focus_handler 
	formatText checksumName = hiliteId 'hilite%i' i = <i>
	SetScreenElementProps id = <hiliteId> alpha = 1
endscript

script winport_gfx_unfocus_handler 
	formatText checksumName = hiliteId 'hilite%i' i = <i>
	SetScreenElementProps id = <hiliteId> alpha = 0
endscript

script winport_gfx_option_handler 
	formatText checksumName = valueId 'value%i' i = <i>
	SetScreenElementProps id = <valueId> rgba = $winport_gfx_text_highlight_color
	formatText checksumName = choiceMenuId 'choiceMenu%i' i = <i>
	formatText checksumName = choiceItemId 'choiceItem%i_%c' i = <i> c = ($winport_gfx_values_new [<i>])
	LaunchEvent \{Type = unfocus
		target = menu}
	LaunchEvent Type = focus target = <choiceMenuId> data = {child_id = <choiceItemId>}
	winport_gfx_focus_handler i = <i>
endscript

script winport_gfx_choice_end_handler 
	formatText checksumName = valueId 'value%i' i = <i>
	SetScreenElementProps id = <valueId> rgba = $winport_gfx_text_color
	formatText checksumName = choiceMenuId 'choiceMenu%i' i = <i>
	LaunchEvent Type = unfocus target = <choiceMenuId>
	LaunchEvent \{Type = focus
		target = menu}
endscript

script winport_create_gfx_settings_restart_popup_menu 
	create_popup_warning_menu \{textblock = {
			text = "Graphics option changes will not take effect until the game is restarted."
		}
		menu_pos = (640.0, 490.0)
		dialog_dims = (288.0, 64.0)
		options = [
			{
				func = {
					ui_flow_manager_respond_to_action
					params = {
						action = continue
					}
				}
				text = "CONTINUE"
				Scale = (1.0, 1.0)
			}
		]}
endscript

script winport_destroy_gfx_settings_restart_popup_menu 
	destroy_popup_warning_menu
endscript
