confirm_band_delete_menu_font = fontgrid_title_gh3

script create_confirm_band_delete_menu 
	new_menu \{scrollid = cbd_warning_scroll
		vmenuid = cbd_warning_vmenu
		menu_pos = (605.0, 469.0)
		spacing = -20}
	set_focus_color \{rgba = [
			130
			0
			0
			250
		]}
	set_unfocus_color \{rgba = [
			0
			0
			0
			255
		]}
	createscreenelement \{type = containerelement
		parent = root_window
		id = cbd_container
		pos = (0.0, 0.0)
		just = [
			left
			top
		]}
	offwhite = [223 223 223 255]
	z = 100
	displaysprite parent = cbd_container tex = dialog_title_bg flip_v pos = (416.0, 60.0) scale = (1.75, 1.75) z = <z>
	displaysprite parent = cbd_container tex = dialog_title_bg pos = (640.0, 60.0) scale = (1.75, 1.75) z = <z>
	displaysprite parent = cbd_container tex = white pos = (525.0, 524.0) scale = (58.0, 6.0) z = (<z> + 0.1) rgba = <offwhite>
	displaysprite parent = cbd_container tex = dialog_frame_joiner pos = (510.0, 510.0) rot_angle = 5 scale = (1.575, 1.5) z = (<z> + 0.2)
	displaysprite parent = cbd_container tex = dialog_frame_joiner pos = (723.0, 514.0) flip_v rot_angle = -5 scale = (1.575, 1.5) z = (<z> + 0.2)
	displaysprite parent = cbd_container tex = dialog_bg pos = (514.0, 467.0) scale = (1.0, 1.25) z = <z>
	displaysprite parent = cbd_container tex = dialog_bg flip_h pos = (514.0, 537.0) scale = (1.0, 1.25) z = <z>
	displaysprite id = hi_right parent = cbd_container tex = dialog_highlight pos = (770.0, 533.0) scale = (1.0, 1.0) z = (<z> + 0.3)
	displaysprite id = hi_left parent = cbd_container tex = dialog_highlight flip_v pos = (500.0, 533.0) scale = (1.0, 1.0) z = (<z> + 0.3)
	create_pause_menu_frame \{x_scale = 1.2
		z = 98}
	create_confirm_band_delete_warning_text z = <z>
	create_confirm_band_delete_warning_menu_options z = <z>
endscript

script destroy_confirm_band_delete_menu 
	destroy_pause_menu_frame
	destroy_menu_backdrop
	destroy_menu \{menu_id = cbd_warning_scroll}
	destroy_menu \{menu_id = cbd_container}
endscript

script create_confirm_band_delete_warning_text 
	createscreenelement {
		type = textelement
		font = ($confirm_band_delete_menu_font)
		text = "WARNING"
		just = [center center]
		pos = (640.0, 180.0)
		scale = 1.3
		parent = cbd_container
		rgba = [200 200 200 255]
		shadow
		shadow_offs = (4.0, 4.0)
		shadow_rgba = [0 0 0 255]
		z_priority = (<z> + 6)
	}
	text = [
		"You are about to permanently delete the selected band. "
		"All progress associated with that band will be lost. "
		"Are you sure you want to continue?"
	]
	createscreenelement {
		type = textblockelement
		font = ($confirm_band_delete_menu_font)
		text = <text>
		just = [center center]
		pos = (640.0, 360.0)
		dims = (700.0, 500.0)
		scale = (0.75, 0.6)
		parent = cbd_container
		rgba = [210 130 0 250]
		shadow
		shadow_offs = (5.0, 5.0)
		shadow_rgba = [0 0 0 255]
		z_priority = (<z> + 1)
	}
endscript

script create_confirm_band_delete_warning_menu_options 
	createscreenelement {
		type = textelement
		font = ($confirm_band_delete_menu_font)
		parent = cbd_warning_vmenu
		text = "NO"
		scale = 1
		rgba = ($menu_unfocus_color)
		event_handlers = [
			{focus menu_confirm_band_delete_highlight_no}
			{unfocus retail_menu_unfocus}
			{pad_choose menu_confirm_band_delete_select_no}
		]
		z_priority = (<z> + 5)
	}
	createscreenelement {
		type = textelement
		font = ($confirm_band_delete_menu_font)
		parent = cbd_warning_vmenu
		text = "YES"
		scale = 1
		rgba = ($menu_unfocus_color)
		event_handlers = [
			{focus menu_confirm_band_delete_highlight_yes}
			{unfocus retail_menu_unfocus}
			{pad_choose menu_confirm_band_delete_select_yes}
		]
		z_priority = (<z> + 5)
	}
endscript

script menu_confirm_band_delete_highlight_no 
	retail_menu_focus
	setscreenelementprops \{id = hi_left
		pos = (545.0, 502.0)
		flip_v}
	setscreenelementprops \{id = hi_right
		pos = (680.0, 502.0)}
endscript

script menu_confirm_band_delete_highlight_yes 
	retail_menu_focus
	setscreenelementprops \{id = hi_left
		pos = (540.0, 548.0)
		flip_v}
	setscreenelementprops \{id = hi_right
		pos = (685.0, 548.0)}
endscript

script menu_confirm_band_delete_select_no 
	ui_flow_manager_respond_to_action \{action = go_back}
endscript

script menu_confirm_band_delete_select_yes 
	band_count = ($current_band)
	getarraysize \{$difficulty_list}
	array_count = 0
	begin
	get_difficulty_text_nl difficulty = ($difficulty_list [<array_count>])
	formattext checksumname = bandname 'p1_career_band%i_%d' i = ($num_career_bands + 1) d = <difficulty_text_nl> addtostringlookup = true
	pop_bandtags bandname = <bandname>
	formattext checksumname = bandname 'p1_career_band%i_%d' i = <band_count> d = <difficulty_text_nl> addtostringlookup = true
	push_bandtags bandname = <bandname> mode = p1_career
	formattext checksumname = bandname 'p2_career_band%i_%d' i = ($num_career_bands + 1) d = <difficulty_text_nl> addtostringlookup = true
	pop_bandtags bandname = <bandname>
	formattext checksumname = bandname 'p2_career_band%i_%d' i = <band_count> d = <difficulty_text_nl> addtostringlookup = true
	push_bandtags bandname = <bandname> mode = p2_career
	formattext checksumname = default_bandname 'band%i_info_p1_career' i = <band_count> addtostringlookup = true
	setglobaltags <default_bandname> params = {($default_bandtags)}
	formattext checksumname = default_bandname 'band%i_info_p2_career' i = <band_count> addtostringlookup = true
	setglobaltags <default_bandname> params = {($default_bandtags)}
	array_count = (<array_count> + 1)
	repeat <array_size>
	if iswinport
		savetomemorycard \{filename = $memcard_file_name
			filetype = progress
			usepaddingslot = always}
	endif
	ui_flow_manager_respond_to_action \{action = continue}
endscript
