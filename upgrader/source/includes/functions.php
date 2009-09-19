<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1251220322 - Tuesday, August 25, 2009, 01:12:02 PM EDT -0400
	// ======================================== /
	
	class mmhclass_core_functions
	{
		// Class Initialization Method
		function __construct() { global $mmhclass; $this->mmhclass = &$mmhclass; }
		
		function is_null($string) 
		{
			return ((empty($string) == false && $string !== 0 && $string !== "0") ? false : true);
		}
		
		function clean_array($array)
		{
			if (is_array($array) == true && $this->is_null($array) == false) {
				foreach ($array as $key => $value) {
					unset($array[$key]);
					$new_key = strtolower($key);
					if (is_array($value) == true) {
						$array[$new_key] = $this->clean_array($value);
					} elseif ($this->is_null($value) == false) {
						$array[$new_key] = trim((get_magic_quotes_gpc() == 1) ? stripslashes($value) : $value);
					}
				}
			}
			
			return $array;
		}
		
		function is_url($url)
		{
			$urlparts = parse_url($url);
			return ((isset($urlparts['scheme']) == true && isset($urlparts['host']) == true && isset($urlparts['path']) == true) ? true : false);
		}
		
		function get_http_content($url, $timeout = 3)
		{
			if ($this->is_url($url) == true) {
				if (extension_loaded("curl") == true) {
					$curl_handle = curl_init();
					curl_setopt($curl_handle, CURLOPT_URL, $url);
					curl_setopt($curl_handle, CURLOPT_MAXREDIRS, 5);
					curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
					curl_setopt($curl_handle, CURLOPT_FOLLOWLOCATION, true);
					curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, $timeout);
					curl_setopt($curl_handle, CURLOPT_USERAGENT, "Mihalism Multi Host @ {$this->mmhclass->info->base_url}");
					$returned_c = curl_exec($curl_handle); curl_close($curl_handle); return $returned_c;
				} else {
					if (strtolower(ini_get("allow_url_fopen")) == "on" || ini_get("allow_url_fopen") == 1) {
						$fileh = fopen($url, "rb");
						stream_set_timeout($fileh, $timeout);
						$return_c = stream_get_contents($fileh);
						fclose($fileh); return $return_c;
					}
				}
			}
		}
		
		function get_old_version($datafile)
		{
			$datafile = file($datafile);
			foreach ($datafile as $line => $code) {
				if (isset($theline) == false) {
					if (stripos($code, "mmhclass->info->version") !== false) {
						$theline = $line;
					}
				}
			}
			
			preg_match("#\"([^\s]+)\"#", $datafile[$theline], $matches);
			return $matches['1'];
		}
		
		function fetch_url($base = true, $www = true, $query = true)
		{
			$the_url = (($this->is_null($this->mmhclass->input->server_vars['https']) == false) ? "https://" : "http://");
			$the_url .= (($www == true && preg_match("/^www\./", $this->mmhclass->input->server_vars['http_host']) == false) ? "www.{$this->mmhclass->input->server_vars['http_host']}" : $this->mmhclass->input->server_vars['http_host']);
			$the_url .= ((pathinfo($this->mmhclass->input->server_vars['php_self'], PATHINFO_DIRNAME) !== "/") ? sprintf("%s/", pathinfo($this->mmhclass->input->server_vars['php_self'], PATHINFO_DIRNAME)) : pathinfo($this->mmhclass->input->server_vars['php_self'], PATHINFO_DIRNAME)); 
			$the_url .= (($base == true) ? pathinfo($this->mmhclass->input->server_vars['php_self'], PATHINFO_BASENAME) : NULL);
			$the_url .= (($query == true && $this->is_null($this->mmhclass->input->server_vars['query_string']) == false) ? "?{$this->mmhclass->input->server_vars['query_string']}" : NULL); 
			return ((strtoupper(substr(PHP_OS, 0, 3)) === "WIN") ? str_replace("\/", "/", $the_url) : $the_url); 
		}
	}
	
?>