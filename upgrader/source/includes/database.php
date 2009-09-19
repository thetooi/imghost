<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1251219558 - Tuesday, August 25, 2009, 12:59:18 PM EDT -0400
	// ======================================== /
	
	class mmhclass_mysql_driver
	{
		// Class Initialization Method
		function __construct() { global $mmhclass; $this->mmhclass = &$mmhclass; }
		
		function connect($host = "localhost", $username, $password, $database, $port = 3306, $boolerror = false)
		{
			$connection_id = mysql_connect("{$host}:{$port}", $username, $password, true);
			
			if (is_resource($connection_id) == false) {
				return false;
			} else {
				if (mysql_select_db($database, $connection_id) == false) {
					return false;
				} else {
					if (is_resource($this->root_connection) == false) {
						$this->root_connection = $connection_id;
					}
				}
			}
			
			return $connection_id;
		}
		
		function close()
		{
			if (is_resource($this->root_connection) == true) {
				mysql_close($this->root_connection);
			}
		}
		
		function query($query, $input = NULL, $addon = NULL)
		{
			if (is_resource($this->root_connection) == false) {
				$this->connect($this->mmhclass->info->config['sql_host'], $this->mmhclass->info->config['sql_username'], $this->mmhclass->info->config['sql_password'], $this->mmhclass->info->config['sql_database']);
			}
			
			if (is_array($addon) == true && empty($addon) == false) {
				foreach ($addon as $key => $replacement) {
					$query = str_replace(sprintf("[[%s]]", ($key + 1)), stripslashes($replacement), $query);
				}
			}
			
			if (is_array($input) == true && empty($input) == false) {
				foreach ($input as $key => $replacement) {
					$query = str_replace(sprintf("[%s]", ($key + 1)), mysql_real_escape_string(str_replace(array("[", "]"), array("\[", "\]"), stripslashes($replacement))), $query);
				}
			}
			
			$query = str_replace(array("\[", "\]"), array("[", "]"), $query);
			$this->query_result = mysql_query($query, $this->root_connection);
			return (($this->query_result == false) ? false : $this->query_result);
		}
		
		function total_rows($query_id)
		{
			return mysql_num_rows($query_id);
		}
		
		function fetch_array($query_id, $result_type = MYSQL_ASSOC)
		{
			return mysql_fetch_array($query_id, $result_type);
		}
		
		function execute_upgrade_queries($queries)
		{
			foreach ($queries as $id => $the_query) {
				if (is_array($the_query) == true) {
					$result = $this->query($the_query['0'], $the_query['1']);
				} else {
					$result = $this->query($the_query);
				}
				
				echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
				if ($result == false) {
					echo sprintf("Query #%s: <span style=\"color: #F00;\"><strong>Failed!</strong></span><br />", ($id + 1));
				} else {
					echo sprintf("Query #%s: <span style=\"color: #096\"><strong>Executed.</strong></span><br />", ($id + 1));
				}
			}
		}
	}
	
?>