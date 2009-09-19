<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1251219985 - Tuesday, August 25, 2009, 01:06:25 PM EDT -0400
	// ======================================== /
	
	/* 5.0.0 => 5.0.1 */
	
	function upgrade_500501()
	{
		global $mmhclass;
	
		$mmhclass->db->upgrade_queries = array();
		
		$mmhclass->db->upgrade_queries[] = "INSERT INTO `mmh_site_settings` (`config_key`, `config_value`) VALUES ('thumbnail_type', 'png');";
		
		$mmhclass->db->execute_upgrade_queries($mmhclass->db->upgrade_queries);
	}

?>
