<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1252713557 - Friday, September 11, 2009, 07:59:17 PM EDT -0400
	// ======================================== /
	
	require_once "./source/includes/data.php";
	require_once "{$mmhclass->info->root_path}source/language/home.php";
	
	// Module file loader
	if (isset($mmhclass->input->get_vars['module']) == true) {
		$module_name = $mmhclass->image->basename($mmhclass->input->get_vars['module']);
		
		if ($mmhclass->funcs->file_exists("{$mmhclass->info->root_path}source/modules/{$module_name}.php") == true) {
			require_once "{$mmhclass->info->root_path}source/modules/{$module_name}.php"; 
			
			exit;	
		}
	}
	
	// Upload progress bar
	if ($mmhclass->input->get_vars['act'] == "upload_in_progress") {
		exit($mmhclass->templ->parse_template("home", "upload_in_progress_lightbox"));
	}
	
	// Random Image
	if (isset($mmhclass->input->get_vars['do_random']) == true) {
		$sql = $mmhclass->db->query("SELECT * FROM `[1]` WHERE `is_private` = '0' AND `gallery_id` = '0' ORDER BY RAND() LIMIT 1;", array(MYSQL_FILE_STORAGE_TABLE));
		
		if ($mmhclass->db->total_rows($sql) !== 1) {
			$mmhclass->templ->error($mmhclass->lang['006'], true);
		} else {	
			$file_info = $mmhclass->db->fetch_array($sql);
			
			header("Location: {$mmhclass->info->base_url}viewer.php?is_random={$file_info['file_id']}&file={$file_info['filename']}");
			
			exit;
		}
	}

	// Disable uploading? -- Does not apply to administrators
	if ($mmhclass->info->config['uploading_disabled'] == true && $mmhclass->info->is_admin == false) {
		$mmhclass->templ->page_title = $mmhclass->lang['005'];
		
		$mmhclass->templ->error($mmhclass->lang['004'], true);
	}

	// Disable uploading for Guests only?
	if ($mmhclass->info->config['useronly_uploading'] == true && $mmhclass->info->is_user == false) {
		$mmhclass->templ->page_title = sprintf($mmhclass->lang['001'], $mmhclass->info->config['site_name']);
		
		$mmhclass->templ->error($mmhclass->lang['007'], true);
	}
	
	// Upload Layout Preview Lightbox
	if (isset($mmhclass->input->get_vars['layoutprev']) == true) {
		$mmhclass->templ->templ_vars[] = array(
			"LIGHTBOX_ID" => $mmhclass->input->get_vars['lb_div'],
			"IMAGE_HEIGHT" => (($mmhclass->input->get_vars['layoutprev'] == "std") ? 280 : 454),
			"PREVIEW_TYPE" => (($mmhclass->input->get_vars['layoutprev'] == "std") ? "std" : "bx"),
		);
		
		exit($mmhclass->templ->parse_template("home", "upload_layout_preview_lightbox"));
	}
		
	// Normal and URL upload page
	$last_extension = end($mmhclass->info->config['file_extensions']);
	
	foreach ($mmhclass->info->config['file_extensions'] as $this_extension) {
		$file_extensions .= sprintf((($last_extension == $this_extension) ? "{$mmhclass->lang['003']} .%s" : ".%s, "), strtoupper($this_extension));
	}
	
	/* "Upload To" addon developed by Josh D. of www.hostmine.us */
	if ($mmhclass->info->is_user == true) {
		$sql = $mmhclass->db->query("SELECT * FROM `[1]` WHERE `gallery_id` = '[2]' LIMIT 50;", array(MYSQL_GALLERY_ALBUMS_TABLE, $mmhclass->info->user_data['user_id']));
		
		if ($mmhclass->db->total_rows($sql) < 1) {
			$mmhclass->templ->templ_globals['hide_upload_to'] = true;
		} else {
			$template_id = ((isset($mmhclass->input->get_vars['url']) == false) ? "normal_upload_page" : "url_upload_page");
			
			while ($row = $mmhclass->db->fetch_array($sql)) {
				$mmhclass->templ->templ_globals['get_whileloop'] = true;
				
				$mmhclass->templ->templ_vars[] = array(
					"ALBUM_ID" => $row['album_id'],
					"ALBUM_NAME" => $row['album_title'],
				);
				
				$mmhclass->templ->templ_globals['albums_pulldown_whileloop'] .= $mmhclass->templ->parse_template("home", $template_id);
				unset($mmhclass->templ->templ_vars, $mmhclass->templ->templ_globals['get_whileloop']);
			}
		}
	}

	$mmhclass->templ->templ_vars[] = array(
		"FILE_EXTENSIONS" => $file_extensions,
		"SITE_NAME" => $mmhclass->info->config['site_name'],
		"MAX_RESULTS" => $mmhclass->info->config['max_results'],
		"MAX_FILESIZE" => $mmhclass->image->format_filesize($mmhclass->info->config['max_filesize']),
		"BOXED_UPLOAD_YES" => (($mmhclass->info->user_data['upload_type'] == "boxed") ? "checked=\"checked\"" : NULL),
		"STANDARD_UPLOAD_YES" => (($mmhclass->info->user_data['upload_type'] == "standard" || $mmhclass->info->is_user == false) ? "checked=\"checked\"" : NULL),
	);
	
	if ($mmhclass->funcs->is_null($mmhclass->input->get_vars['url']) == true) {
		$mmhclass->templ->page_title = sprintf($mmhclass->lang['001'], $mmhclass->info->config['site_name']);
		$mmhclass->templ->output("home", "normal_upload_page");
	} else {
		$mmhclass->templ->page_title = sprintf($mmhclass->lang['002'], $mmhclass->info->config['site_name']);
		$mmhclass->templ->output("home", "url_upload_page");
	}
	
?>