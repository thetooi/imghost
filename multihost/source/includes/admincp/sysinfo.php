<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1253476748 - Sunday, September 20, 2009, 03:59:08 PM EDT -0400
	// ======================================== /
	
	// ======================================== \
	// Written by: Mihalism Technologies (www.mihalism.net)
	// Contributions by: Michael Manley (mmanley@nasutek.com)
	//
	// Unix/Linux Functions based off: Debian GNU/Linux 5.0
	// Mac OS X (Darwin) Functions based off: Mac OS X 10.5.8 (9L30)
	// Windows Operating System Functions based off: Windows XP Professional (Service Pack 3)
	// ======================================== /
	
	// Running Processes
	
	function _get_processes()
	{
		$command = ((IS_WINDOWS_OS == true) ? "tasklist" : "top -b -n 1");
			
		$topinfo = @shell_exec($command);
		
		return (($topinfo === false) ? false : trim($topinfo));
	}

	// Disk Space Information

	function _get_diskspace_info()
	{
		// Check root file system (if possible) to get total system 
		// usage, but some hosts jail us in, so let us check options.
		
		$root_path = ((IS_WINDOWS_OS == true) ? "C:" : "/");
		
		$check_path = ((PHP_IS_JAILED == true || is_readable($root_path) == false) ? "." : $root_path);
		
		$free_space = disk_free_space($check_path);
		$total_space = disk_total_space($check_path);
		
		if (is_float($free_space) == false || is_float($total_space) == false) {
			return false;	
		} else {
			$used_space = ($total_space - $free_space);
			
			return array(
				"used" => $used_space,
				"free" => $free_space,
				"total" => $total_space, 
			);
		}
	}
	
	// Memory Information
	
	function _get_memory_info()
	{
		if (IS_WINDOWS_OS == true) {
			$obj = new COM('winmgmts:{impersonationLevel=impersonate}//./root/cimv2');
				
			foreach ($obj->instancesof("Win32_ComputerSystem") as $mp) {
				$ram_total = $mp->TotalPhysicalMemory;
					
				break;
			}
				
			foreach ($obj->instancesof("Win32_OperatingSystem") as $mp) {
				$ram_free = $mp->FreePhysicalMemory;
				$swap_free = $mp->FreeVirtualMemory;
				$swap_total = $mp->TotalVirtualMemorySize;
				
				$swap_used = ($swap_total - $swap_free);
				$ram_used = ($ram_total - ($ram_free * 1024));
				
				break;
			}
		} elseif (IS_DARWIN_OS == true) {
			$ram_info = @shell_exec("sysctl hw.memsize");
			
			if ($ram_info === false) {
				return false;
			} else {
				$ram_info = explode(" ", $ram_info);
				
				$ram_total = (int)$ram_info['1'];
			}
			
			$ram_info = @shell_exec("vm_stat");
			
			if ($ram_info === false) {
				return false;
			} else {
				preg_match("#Pages free:\s+([^\n]+)\.\n#", $ram_info, $matches);
				
				if (isset($matches['1']) == false) {
					return false;	
				} else {
					$ram_free = ((int)$matches['1'] * 4096);
					
					$ram_used = ($ram_total - $ram_free);
				}
			}
			
			$swap_info = @shell_exec("sysctl vm.swapusage");
			
			if ($swap_info === false) {
				return false;
			} else {
				preg_match_all("#([a-zA-Z0-9]+) = ([^M]+)#i", $swap_info, $matches);
				
				$variable_names = array("total" => "swap_total", "free" => "swap_free");
				
				foreach ($matches['1'] as $id => $value) {
					if (array_key_exists($value, $variable_names) == true) {
						$variable_name = $variable_names[$value];
						$$variable_name = ($matches['2'][$id] * 1048576);
					}
				}
				
				$swap_used = ($swap_total - $swap_free);
			}
		} else {
			$ram_usage = @shell_exec("cat /proc/meminfo");
			
			if ($ram_usage === false) {
				return false;
			} else {
				$variable_names = array("SwapTotal:" => "swap_total", "SwapFree:" => "swap_free", "MemTotal:" => "ram_total", "MemFree:" => "ram_free", "Buffers:" => "ram_buffers", "Cached:" => "ram_cached");
					
				preg_match_all("#([^\s]+)\s+([0-9]+)\s*kB\n#i", $ram_usage, $ram_info);
			
				foreach ($ram_info['1'] as $id => $value) {
					if (array_key_exists($value, $variable_names) == true) {
						$variable_name = $variable_names[$value];
						$$variable_name = ($ram_info['2'][$id] * 1024);
					}
				}
		
				$ram_free = ($ram_free + $ram_cached + $ram_buffers);
				$ram_used = ($ram_total - $ram_free);
				
				$swap_used = ($swap_total - $swap_free);
			}
		}
		
		if (isset($ram_total, $ram_free, $swap_free, $swap_total) === false) {
			return false;
		} else {
			return array(
				"ram" => array(
					"free" => $ram_free,
					"used" => $ram_used,
					"total" => $ram_total,
				),
				
				"swap" => array(
					"free" => $swap_free,
					"used" => $swap_used,
					"total" => $swap_total,
				),
			);
		}
	}	
	
	// Uptime Information
	
	function _get_uptime_info()
	{
		if (IS_WINDOWS_OS == true) {
			$upsince = @filemtime("C:\pagefile.sys");
			
			if ($upsince === false) {
				return false;
			} else {
				$total_uptime = round(((time() - $upsince) / 86400), 1); 
			}
		} elseif (IS_DARWIN_OS == true) {
			$uptime_info = @shell_exec("sysctl -n kern.boottime");
			
			if ($uptime_info === false) {
				return false;
			} else {
				preg_match("#sec = ([0-9]{10})#", $uptime_info, $matches);
				
				if (isset($matches['1']) === false) {
					return false;	
				} else {
					$uptime_data = (time() - (int)$matches['1']);
					
					$total_uptime = round(($uptime_data / 86400), 1); 
				}
			}
		} else {
			$uptime_info = @shell_exec("cat /proc/uptime");
			
			if ($uptime_info === false) {
				return false;
			} else {
				$uptime_data = explode(" ", $uptime_info, 2);
				 
				$total_uptime = round(($uptime_data['0'] / 86400), 1); 
			}
		}
		
		return (int)$total_uptime;
	}
	
	// Processor (CPU) Information
	
	function _get_cpu_info()
	{
		if (IS_WINDOWS_OS == true) {
			$obj = new COM('winmgmts:{impersonationLevel=impersonate}//./root/cimv2');
				
			foreach ($obj->instancesof("Win32_Processor") as $mp) {
				$cpu_model = $mp->Name;
				$cpu_speed = $mp->CurrentClockSpeed;
				$cpu_usage = array($mp->LoadPercentage);
					
				break;
			}
		} elseif (IS_DARWIN_OS == true) {
			$cpu_info = @shell_exec("uptime");
			
			if ($cpu_info === false) {
				return false;
			} else {
				preg_match("#load averages: (.*)#i", $cpu_info, $matches);
				
				if (isset($matches['1']) === false) {
					return false;
				} else {
					$cpu_usage = explode(" ", $matches['1']);
				}
			}
			
			$cpu_info = @shell_exec("system_profiler SPHardwareDataType");
			
			if ($cpu_info === false) {
				return false; 
			} else {
				$variable_names = array("Processor Name" => "cpu_model", "Processor Speed" => "cpu_speed");
			
				preg_match_all("#\s+([^\:]+):\s([^\n]+)\n#", $cpu_info, $matches);
				
				foreach ($matches['1'] as $id => $value) {
					if (array_key_exists($value, $variable_names) == true) {
						$variable_name = $variable_names[$value];
						$$variable_name = $matches['2'][$id];
					}
				}
				
				$cpu_speed = str_replace(" GHz", NULL, $cpu_speed);
			}
		} else {
			$cpu_info = @shell_exec("cat /proc/loadavg");
			
			if ($cpu_info === false) {
				return false; 
			} else {
				$cpu_usage = explode(" ", $cpu_info, 4);
			}
			
			$cpu_info = shell_exec("cat /proc/cpuinfo -T");
			
			if ($cpu_info === false) {
				return false; 
			} else {
				$variable_names = array("model name" => "cpu_model", "cpu MHz" => "cpu_speed");
					
				$cpu_info = str_replace("^I", NULL, $cpu_info);	
				
				preg_match_all("#([^:]+):\s([^\n]+)\n#i", $cpu_info, $cpu_minfo);
				
				foreach ($cpu_minfo['1'] as $id => $value) {
					if (array_key_exists($value, $variable_names) == true) {
						$variable_name = $variable_names[$value];
						$$variable_name = $cpu_minfo['2'][$id];
					}
				}
				
				$cpu_speed = @number_format(round(($cpu_speed / 1000), 2), 2);
			}
		}		
		
		if (isset($cpu_speed, $cpu_model, $cpu_usage) === false) {
			return false;	
		} else {
			return array(
				"load" => $cpu_usage,
				"model" => $cpu_model,
				"speed" => $cpu_speed,
			);
		}
	}
	
	// Operating System Information
	
	function _get_system_name()
	{
		if (IS_WINDOWS_OS == true) {
			$obj = new COM('winmgmts:{impersonationLevel=impersonate}//./root/cimv2');
				
			foreach ($obj->instancesof("Win32_OperatingSystem") as $mp) {
				$system_version = $mp->Caption;
					
				break;
			}
		} elseif (IS_DARWIN_OS == true) {
			$version_info = @shell_exec("system_profiler SPSoftwareDataType");
			
			if ($version_info === false) {
				return false;
			} else {
				preg_match("#System Version: ([^\n]+)#i", $version_info, $matches);
				
				if (isset($matches['1']) === false) {
					return false;
				} else {
					$system_version = $matches['1'];
				}
			}
		} else {
			$version_info = @shell_exec("cat /etc/issue");
			
			if ($version_info === false) {
				return false;
			} else {
				$system_version = str_replace(array("\\n", "\\l"), NULl, trim($version_info));
			}
		}	
		
		return ((isset($system_version) === false) ? false : (string)$system_version);
	}

?>