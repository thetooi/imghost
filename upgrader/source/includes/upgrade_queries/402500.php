<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1251219666 - Tuesday, August 25, 2009, 01:01:06 PM EDT -0400
	// ======================================== /
	
	/* 4.0.2 => 5.0.0 */
	
	function upgrade_402500()
	{
		global $mmhclass;
	
		$mmhclass->db->upgrade_queries = array();
		
		$server_token = base64_encode(serialize(array("url" => $mmhclass->info->base_url, "time" => time(), "admin" => $mmhclass->input->server_vars['server_admin'], "version" => $mmhclass->info->upgrade_to, "site" => $mmhclass->input->server_vars['http_host'])));
		$server_license = $mmhclass->funcs->get_http_content("http://callhome.mihalism.net/multihost/?id={$server_token}", 1);
		
		$mmhclass->db->upgrade_queries[] = "INSERT INTO `mmh_site_settings` (`config_key`, `config_value`) VALUES ('uploading_disabled', '0');";
		$mmhclass->db->upgrade_queries[] = "INSERT INTO `mmh_site_settings` (`config_key`, `config_value`) VALUES ('registration_disabled', '0');";
		$mmhclass->db->upgrade_queries[] = "INSERT INTO `mmh_site_settings` (`config_key`, `config_value`) VALUES ('useronly_uploading', '0');";
		$mmhclass->db->upgrade_queries[] = "INSERT INTO `mmh_site_settings` (`config_key`, `config_value`) VALUES ('recaptcha_public', '6Le1xAUAAAAAAJfAE0pXUDSvN-sHVp6y337IzLZ5');";
		$mmhclass->db->upgrade_queries[] = "INSERT INTO `mmh_site_settings` (`config_key`, `config_value`) VALUES ('recaptcha_private', '6Le1xAUAAAAAAHIv7fSE0Tqn-05yf7lfWupzFrwS');";
		$mmhclass->db->upgrade_queries[] = "INSERT INTO `mmh_site_settings` (`config_key`, `config_value`) VALUES ('google_analytics', 'UA-1125794-2');";
		$mmhclass->db->upgrade_queries[] = array("INSERT INTO `mmh_site_settings` (`config_key`, `config_value`) VALUES ('server_license', '[1]');", array($server_license));
		$mmhclass->db->upgrade_queries[] = array("INSERT INTO `mmh_site_settings` (`config_key`, `config_value`) VALUES ('email_in', '[1]');", array("noreply@{$mmhclass->input->server_vars['http_host']}"));
		$mmhclass->db->upgrade_queries[] = "INSERT INTO `mmh_robot_info` (`robot_id`, `preg_match`, `robot_name`) VALUES (52, 'W3C_CSS_Validator', 'W3C [Validator]');";
		$mmhclass->db->upgrade_queries[] = "INSERT INTO `mmh_robot_info` (`robot_id`, `preg_match`, `robot_name`) VALUES (53, 'W3C_Validator', 'W3C [Validator]');";
		$mmhclass->db->upgrade_queries[] = "RENAME TABLE `mmh_user_forgotten_passwords` TO `mmh_user_passwords`;";
		$mmhclass->db->upgrade_queries[] = "ALTER TABLE `mmh_user_info` ADD `upload_type` VARCHAR(8) NOT NULL DEFAULT 'standard';";
		$mmhclass->db->upgrade_queries[] = "ALTER TABLE `mmh_gallery_albums` ADD `password` VARCHAR(32) NOT NULL, ADD `is_private` TINYINT(1) NOT NULL DEFAULT '0';";
		$mmhclass->db->upgrade_queries[] = "ALTER TABLE `mmh_file_storage` ADD `viewer_clicks` INT(25) NOT NULL DEFAULT '1';";
		$mmhclass->db->upgrade_queries[] = "ALTER TABLE `mmh_file_ratings` ADD `is_private` TINYINT(1) NOT NULL DEFAULT '0', ADD `gallery_id` INT(25) NOT NULL DEFAULT '0';";
		$mmhclass->db->upgrade_queries[] = "ALTER TABLE  `mmh_file_logs` ADD `upload_type` VARCHAR(6) NOT NULL DEFAULT 'normal';";
		$mmhclass->db->upgrade_queries[] = "DROP TABLE `mmh_captcha_sessions`;";
		$mmhclass->db->upgrade_queries[] = "TRUNCATE `mmh_user_sessions`;";
		$mmhclass->db->upgrade_queries[] = "DELETE FROM `mmh_robot_info` WHERE `preg_match` = 'W3C_*Validator';";
		
		$mmhclass->db->execute_upgrade_queries($mmhclass->db->upgrade_queries);
	}

?>
