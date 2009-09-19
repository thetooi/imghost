<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1251221600 - Tuesday, August 25, 2009, 01:33:20 PM EDT -0400
	// ======================================== /
	
	/* Not a pretty upgrader, but she gets the job done. *pets* */
	
	$mmhclass = new stdClass;
	$mmhclass->info = new stdClass;
	$mmhclass->input = new stdClass;

	ini_set("log_errors", 0);
	ini_set("display_errors", 0);
	ini_set("register_globals", 0);
	ini_set("memory_limit", "128M");
	ini_set("post_max_size", "128M");
	
	$mmhclass->info->root_path = sprintf("%s/", realpath(".."));
	$mmhclass->info->upgrade_path = sprintf("%s/", realpath("."));

	require_once "{$mmhclass->info->root_path}source/includes/config.php";
	require_once "{$mmhclass->info->upgrade_path}source/includes/config.php";
	require_once "{$mmhclass->info->upgrade_path}source/includes/database.php";
	require_once "{$mmhclass->info->upgrade_path}source/includes/functions.php";
	
	$mmhclass->db = new mmhclass_mysql_driver();
	$mmhclass->funcs = new mmhclass_core_functions();
	
	$mmhclass->input->get_vars = $mmhclass->funcs->clean_array($_GET);  
	$mmhclass->input->post_vars = $mmhclass->funcs->clean_array($_POST);
	$mmhclass->input->file_vars = $mmhclass->funcs->clean_array($_FILES);
	$mmhclass->input->server_vars = $mmhclass->funcs->clean_array($_SERVER);

	$mmhclass->info->upgrade_from = $mmhclass->funcs->get_old_version("{$mmhclass->info->root_path}source/includes/data.php");
	
	readfile("{$mmhclass->info->upgrade_path}source/public_html/page_header.html");
	
	if (is_array($mmhclass->info->config) == true) {
		$mmhclass->db->connect($mmhclass->info->config['sql_host'], $mmhclass->info->config['sql_username'], $mmhclass->info->config['sql_password'], $mmhclass->info->config['sql_database']);
	}
	
	if ($mmhclass->info->upgrade_to == $mmhclass->info->upgrade_from) {
		echo "Already running latest version!";	
	} else {
		switch ($mmhclass->input->get_vars['act']) {	
			case "upgrade":
				foreach ($mmhclass->info->upgrade_queries as $version => $file) {
					if (version_compare($version, $mmhclass->info->upgrade_from, ">=") == true) {
						$upgrade_packs[$file] = $version;	
					}
				}
			
				echo "Starting Upgrader...";
				echo "<br /><br />";
				echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				echo "<b>1.</b> MySQL upgrade starting... ";
				echo "<br />";
				
				foreach ($upgrade_packs as $file => $version) {
					echo "<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";	
					echo "Upgrading to v{$version}:";
					echo "<br /><br />";
					require_once "{$mmhclass->info->upgrade_path}source/includes/upgrade_queries/{$file}.php";
					$upgrade_function = "upgrade_{$file}";
					$upgrade_function();
				}
				
				echo "<br />";
				echo "<b>Upgrade Complete!</b>";
				echo "<br /><br />";
				echo "Delete this upgrader as soon as possible for security purposes.";
				break;
			default:
				echo "Please confirm the following information before continuing this upgrade of Mihalism Mulit Host.
				<br /><br />
				<b>Upgrading To</b>: Mihalism Multi Host v{$mmhclass->info->upgrade_to}<br />
				<b>Upgrading From</b>: Mihalism Multi Host v{$mmhclass->info->upgrade_from}
				<br /><br />
				<a href=\"index.php?act=upgrade\">&raquo; Continue With Upgrade &raquo;</a>
				<br /><br />
				<b style=\"color: #F00;\">WARNING</b>: There is no undo when you run a upgrade, so backup everything before continuing!";
		}
	}
	
	readfile("{$mmhclass->info->upgrade_path}source/public_html/page_footer.html");
	exit;

?>
