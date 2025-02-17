
script faceoff_init 
	if ($boss_battle = 1)
		return
	endif
	Change structurename = <player_status> gem_filler_enabled_time_on = 0
	Change structurename = <player_status> gem_filler_enabled_time_off = 0
	Change structurename = <player_status> gem_filler_first_note = 0
	printf qs(0x28f9f4f4) d = <time_offset>
	Change \{faceoff_enabled = 1}
	if ($is_network_game)
		if NOT IsHost
			if (<player_text> = 'p1')
				<player_text> = 'p2'
			else
				<player_text> = 'p1'
			endif
		endif
	endif
	get_notetrack_part_text player_status = <player_status> song_name = <song_name>
	get_song_prefix song = <song_name>
	formatText checksumName = note_array '%s_%jfaceoff%p' s = <song_prefix> j = <part> p = <player_text> AddToStringLookup
	GetArraySize $<note_array>
	if (<array_Size> = 0)
		time = 1000000
	else
		time = ($<note_array> [0] [0])
	endif
	if (<Player> = 1)
		Change faceoff_note_array_p1 = <note_array>
		Change \{faceoff_note_array_count_p1 = 0}
		Change faceoff_note_array_size_p1 = <array_Size>
		Change faceoff_note_time_p1 = <time>
		Change faceoff_time_offset_p1 = <time_offset>
	else
		Change faceoff_note_array_p2 = <note_array>
		Change \{faceoff_note_array_count_p2 = 0}
		Change faceoff_note_array_size_p2 = <array_Size>
		Change faceoff_note_time_p2 = <time>
		Change faceoff_time_offset_p2 = <time_offset>
	endif
endscript

script faceoff_deinit 
endscript

script faceoff_volumes_init 
	if ($boss_battle = 1)
		return
	endif
	printf qs(0x2f6515d8) d = <time_offset>
	if ($is_network_game)
		if NOT IsHost
			if (<player_text> = 'p1')
				<player_text> = 'p2'
			else
				<player_text> = 'p1'
			endif
		endif
	endif
	get_song_prefix song = <song_name>
	get_notetrack_part_text player_status = <player_status> song_name = <song_name>
	formatText checksumName = note_array '%s_%ifaceoff%p' s = <song_prefix> i = <part> p = <player_text> AddToStringLookup
	GetArraySize $<note_array>
	if (<array_Size> = 0)
		time = 1000000
	else
		time = ($<note_array> [0] [0])
	endif
	if (<Player> = 1)
		Change faceoffv_note_array_p1 = <note_array>
		Change \{faceoffv_note_array_count_p1 = 0}
		Change faceoffv_note_array_size_p1 = <array_Size>
		Change faceoffv_note_time_p1 = <time>
		Change \{faceoffv_note_on_p1 = 0}
		Change faceoffv_time_offset_p1 = <time_offset>
	else
		Change faceoffv_note_array_p2 = <note_array>
		Change \{faceoffv_note_array_count_p2 = 0}
		Change faceoffv_note_array_size_p2 = <array_Size>
		Change faceoffv_note_time_p2 = <time>
		Change \{faceoffv_note_on_p2 = 0}
		Change faceoffv_time_offset_p2 = <time_offset>
	endif
	if ($is_attract_mode = 1)
		Change \{structurename = player1_status
			guitar_volume = 100}
		Change \{structurename = player2_status
			guitar_volume = 100}
	else
		Change \{structurename = player1_status
			guitar_volume = 100}
		Change \{structurename = player2_status
			guitar_volume = 100}
		Change \{structurename = player1_status
			last_guitar_volume = 100}
		Change \{structurename = player2_status
			last_guitar_volume = 100}
		Change \{structurename = player1_status
			last_faceoff_note = 100}
		Change \{structurename = player2_status
			last_faceoff_note = 100}
	endif
	UpdateGuitarVolume
endscript

script faceoff_volumes_deinit 
	Change structurename = <player_status> gem_filler_enabled_time_on = -1
	Change structurename = <player_status> gem_filler_enabled_time_off = -1
	Change \{faceoff_enabled = 0}
endscript
