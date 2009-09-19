<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1252958872 - Monday, September 14, 2009, 04:07:52 PM EDT -0400
	// ======================================== /
	
	class mmhclass_core_functions
	{
		// Class Initialization Method
		function __construct() { global $mmhclass; $this->mmhclass = &$mmhclass; }
		
		function is_null($string) 
		{
			return ((empty($string) == false && $string !== 0 && $string !== "0") ? false : true);
		}
		
		function clean_array($array, $noclean = false)
		{
			if (is_array($array) == true && $this->is_null($array) == false) {
				$array = array_change_key_case($array);
				
				// Mihalism Multi Host now sets input data as strings.
				// This is done so that it can work with PHP 6.0.0 builds.
				
				foreach ($array as $key => $value) {
					$key = (string)$key;
					
					if (is_array($value) == true) {
						$array[$key] = $this->clean_array($value);
					} elseif ($this->is_null($value) == false) {
						$array[$key] = (string)trim(stripslashes($value));
					}
				}
			}
			
			return $array;
		}
		
		function read_file($filename)
		{
			return @file_get_contents($filename);	
		}
		
		function write_file($filename, $content, $flags = NULL)
		{
			return @file_put_contents($filename, $content, $flags);
		}
		
		function create_tempfile($content)
		{
			$filename = md5($this->random_string(20));	
			
			$file_write = $this->write_file("{$this->mmhclass->info->root_path}source/tempfiles/{$filename}.txt", $content);
			
			return (($file_write == true) ? "{$filename}.txt" : false);
		}
		
		function destroy_tempfile($filename) 
		{
			return @unlink("{$this->mmhclass->info->root_path}source/tempfiles/{$filename}");
		}
		
		function is_url($url, $haspath = true)
		{
			$urlparts = parse_url($url);
			
			if ($urlparts == false) {
				trigger_error("is_url(): URL Parse failed.", E_USER_ERROR);	
			} else {
				$pathcheck = (($haspath == true) ? isset($urlparts['path']) : true);
				
				return ((isset($urlparts['scheme']) == true && isset($urlparts['host']) == true && $pathcheck == true) ? true : false);
			}
		}
		
		function get_http_content($url, $timeout = DEFAULT_SOCKET_TIMEOUT)
		{
			if ($this->is_url($url) == true) {
				if (USE_CURL_LIBRARY == true) {
					$curl_handle = curl_init();
					
					curl_setopt($curl_handle, CURLOPT_URL, $url);
					curl_setopt($curl_handle, CURLOPT_MAXREDIRS, 5);
					curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
					
					if (PHP_IS_JAILED == false) {
						curl_setopt($curl_handle, CURLOPT_FOLLOWLOCATION, 1); 
					}
					
					curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, $timeout);
					curl_setopt($curl_handle, CURLOPT_USERAGENT, "Mihalism Multi Host @ {$this->mmhclass->info->base_url}");
					
					$returned_c = curl_exec($curl_handle); 
					curl_close($curl_handle); 
					
					return $returned_c;
				} else {
					if (REMOTE_FOPEN_ENABLED == true) {
						$fileh = fopen($url, "rb");
						
						stream_set_timeout($fileh, $timeout);
						$return_c = stream_get_contents($fileh);
						fclose($fileh); 
						
						return $return_c;
					} else {
						trigger_error("get_http_content(): Streams not eanbled. cURL Library and Remote fopen not available.", E_USER_ERROR);		
					}
				}
			}
		}
		
		function microtime_float()
		{
			list($usec, $sec) = explode(" ", microtime());
			return ((float)$usec + (float)$sec);
		}
		
		function format_number($number)
		{
			return number_format($number);
		}
		
		function sanitize_string($string) 
		{
			// The characters to retain are from: http://www.php.net/manual/en/filter.filters.sanitize.php
			return preg_replace("/[^a-zA-Z0-9\!#\$%&'\*\+\-\=\?\^_`\{\|\}~@\.\[\]\/\s]/", NULL, $string);	
		}
		
		function shorten_url($url, $length = 45)
		{
			return ((strlen($url) < $length) ? $url : sprintf("%s...", substr($url, 0, $length)));	
		}
		
		function get_headers($url, $redirects = 0) 
		{
			if ($redirects > 6) {
				trigger_error("get_headers(): Too many redirect loops.", E_USER_ERROR);	
			} else {
				if ($this->is_url($url, false) == true) {
					if ($headers = get_headers($url, 1)) {
						if (isset($headers['Location']) == false) {
							return array_merge($headers, array("Address" => $url));
						} else {
							return $this->get_headers($headers['Location'], ($redirects + 1));
						}
					} else {
						if (USE_CURL_LIBRARY == true) {
							$curl_handle = curl_init();
							
							curl_setopt($curl_handle, CURLOPT_URL, $url);
							curl_setopt($curl_handle, CURLOPT_HEADER, 1);
							curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
							curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, DEFAULT_SOCKET_TIMEOUT);
							
							$response = curl_exec($curl_handle); 
							$info = curl_getinfo($curl_handle);
							
							$headers = explode("\n", substr($response, 0, $info['header_size']));
							
							foreach ($headers as $id => $header) {
								$header = trim($header);
								
								if (preg_match("#^Location\: ([^\s]+)$#i", $header) == true) {
									$new_url = str_replace("Location: ", NULL, $header);
									$theheaders = $this->get_headers($new_url, ($redirects + 1));	
								} else {
									$header = explode(":", $header);
									
									$key = ((count($header) > 1) ? $header['0'] : $id);
									$body = ((count($header) > 1) ? $header['1'] : $header['0']);
									
									$theheaders[$key] = trim($body);
								}
							}
							
							$theheaders['Address'] = $url; 
							curl_close($curl_handle); 	
							
							return $theheaders;
						} else {
							trigger_error("get_headers() failed.", E_USER_ERROR);
						}
					}
				}
			}
		}
		
		function file_exists($filename)
		{
			return @is_file($filename);	
		}
		
		// This function should only be used if checking for image in database.
		// As of Mihalism Multi Host 5.0.3, file_exists() is recommended to check
		// normal files. This is recommended because file_exists() requires less.
		
		function is_file($filename, $path = NULL, $checkdb = false, $gallery = 0) 
		{
			$empty_path = $this->is_null($path);
			$base_filename = $this->mmhclass->image->basename($filename);
			
			$file_check = $this->file_exists(($empty_path == false) ? ($path.$base_filename) : $filename);
			$sql_check = (($checkdb == true) ? $this->mmhclass->db->total_rows($this->mmhclass->db->query("SELECT * FROM `[1]` WHERE `filename` = '[2]' [[1]] LIMIT 1;", array(MYSQL_FILE_STORAGE_TABLE, $base_filename), array(($gallery > 0) ? " AND `gallery_id` = '{$gallery}' " : NULL))) : 0);
			
			return (($checkdb == false) ? $file_check : (($file_check == true && $sql_check == 1) ? true : false));
		}
		
		function is_language_file($lang_id)
		{
			$index_check = array_key_exists($lang_id, $this->mmhclass->info->language_files);
			$file_check = $this->is_file("{$this->mmhclass->info->root_path}source/language/{$this->mmhclass->info->language_files[$lang_id]}");
			
			return (($index_check == true && $file_check == true) ? true : false);	
		}
		
		function valid_string($string, $valid_chars = DEFAULT_ALLOWED_CHARS_LIST)
		{
			$stringchunks = str_split($string);
			
			foreach ($stringchunks as $char) {
				if (strpos($valid_chars, $char) === false) {
					return false;
				}
			}
			
			return true;
		}
		
		function string2ascii($string) 
		{
			$normstring = str_split($string);
			
			foreach ($normstring as $char) { 
        		$asciival = ($asciival.sprintf("&#%s;", ord($char))); 
    		}
			
			return trim($asciival);
		}
		
		function ascii2string($string) 
		{
			$asciistring = explode(";", $string);
			
			foreach ($asciistring as $char) { 
        		$stringval = ($stringval.chr((int)str_replace("&#", NULL, $char))); 
    		}
			
			return trim($stringval);
		}
		
		function random_string($max_length = 20, $random_chars = DEFAULT_RANDOM_CHARS_LIST)
		{
			$chararray = array_map("strtolower", str_split($random_chars));
			
			for ($i = 1; $i <= $max_length; $i++)  {
				$random_char = array_rand($chararray);
				$random_string = ($random_string.$chararray[$random_char]);
			}
			
			return str_shuffle($random_string);
		}
		
		function valid_email($email_address)
		{
			if (FILTERS_ARE_AVAILABLE == true) {
				return @filter_var(strtolower($email_address), FILTER_VALIDATE_EMAIL);
			} else {
				return ((preg_match("/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/", strtolower($email_address)) == true) ? true : false);
			}
		}
		
		function fetch_url($base = true, $www = true, $query = true)
		{
			$url_scheme = ((IS_HTTPS_REQUEST == true) ? "https://" : "http://");
			$url_filename = (($base == true) ? pathinfo($this->mmhclass->input->server_vars['php_self'], PATHINFO_BASENAME) : NULL);
			$url_path = ((($path = pathinfo($this->mmhclass->input->server_vars['php_self'], PATHINFO_DIRNAME)) !== "/") ? sprintf("%s/", $path) : $path); 
			$url_query = (($query == true && isset($this->mmhclass->input->server_vars['query_string']) == false) ? "{$the_url}?{$this->mmhclass->input->server_vars['query_string']}" : NULL);
			$url_host = (($www == true && stripos($this->mmhclass->input->server_vars['http_host'], "www.") === false) ? "www.{$this->mmhclass->input->server_vars['http_host']}" : $this->mmhclass->input->server_vars['http_host']);
		
			return ($url_scheme.$url_host.$url_path.$url_filename.$url_query); 
		}
	}
	
?>