<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1252358251 - Monday, September 07, 2009, 05:17:31 PM EDT -0400
	// ======================================== /
	
	$filename = $mmhclass->image->basename($mmhclass->input->get_vars['file']);
	
	$file_info = $mmhclass->image->get_image_info($mmhclass->info->root_path.$mmhclass->info->config['upload_path'].$filename);

	header("Content-Type: image/{$file_info['mime']};");
	header("Content-Disposition: inline; filename={$file_info['thumbnail']};");

	if ($mmhclass->funcs->is_file($filename, $mmhclass->info->root_path.$mmhclass->info->config['upload_path'], true) == false) {
		readfile("{$mmhclass->info->root_path}css/images/error404.gif");
	} elseif ($mmhclass->funcs->file_exists($mmhclass->info->root_path.$mmhclass->info->config['upload_path'].$file_info['thumbnail']) == false) {
		readfile("{$mmhclass->info->root_path}css/images/no_thumbnail.png");
	} else {
		readfile($mmhclass->info->root_path.$mmhclass->info->config['upload_path'].$file_info['thumbnail']);
	}
	
	exit;

?>