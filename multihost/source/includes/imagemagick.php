<?php
	// ======================================== \
	// Package: Mihalism Multi Host
	// Version: 5.0.0
	// Copyright (c) 2007, 2008, 2009 Mihalism Technologies
	// License: http://www.gnu.org/licenses/gpl.txt GNU Public License
	// LTE: 1254124378 - Monday, September 28, 2009, 03:52:58 AM EDT -0400
	// ======================================== /
	
	class mmhclass_image_functions
	{
		// Class Initialization Method
		function __construct() { global $mmhclass; $this->mmhclass = &$mmhclass; }
		
		function file_extension($filename)
		{
			$fileparts = explode(".", $filename);
			
			return strtolower(end($fileparts));
		}
		
		function basename($filename, $extension = NULL)
		{
			if (is_array($filename) == false) {
				return strtolower(basename(trim($filename), $extension));
			} else {
				return array_map("strtolower", array_map("basename", array_map("trim", $filename), array($extension)));	
			}
		}
		
		function is_image($filename)
		{
			if ($this->mmhclass->funcs->file_exists($filename) == true) {
				// exif will be best bet to try first
				
				if (EXIF_IS_AVAILABLE == true) {
					if (exif_imagetype($filename) == false) {
						return false;	
					}
				} else {
					// darn exif is not available! 
					// well hopefully imagick is up
					
					if ($this->manipulator == "imagick") {
						// Why can't Imagick just return a false boolean?
						// Catching error exceptions uses unnecessary code
						
						try {
							$imageh = new Imagick("{$filename}[0]");
							
							if ($imageh == false) {
								return true;
							}
						} catch (Exception $e) {
							return false;
						}
					} else {
						// Come on seriously? No exif or Imagick?
						// GD supports like nothing. Oh well :-(
	
						$imageinfo = getimagesize($filename);
						
						if (isset($imageinfo['2']) == false) {
							return false;	
						}
					}
				}
			} else {
				// Well, well, well. Looks like the image doesn't exist.
				
				// Other than for debugging purposes for former support
				// ticket on mihalism.net, no need to log error for this
				
				trigger_error("mmhclass->image->is_image(): image does not exist. ({$filename})", E_USER_ERROR);
				
				return false;
			}
			
			return true;
		}
		
		function thumbnail_name($filename)
		{
			$file_extension = $this->file_extension($filename);
			$base_filename = $this->basename($filename, ".{$file_extension}");
			
			if ($this->manipulator == "gd") {
				return sprintf("%s_thumb.%s", $base_filename, $file_extension);	
			} else {
				// An easier method could most likely be developed 
				// to do this but this will have to do for now :-)
						
				$real_extension = (($this->mmhclass->info->config['thumbnail_type'] == "png") ? "png" : "jpg");
			
				$check_extension = (($this->mmhclass->info->config['thumbnail_type'] == "png") ? "jpg" : "png");
				$check_thumbtype = (($this->mmhclass->info->config['thumbnail_type'] == "png") ? "jpeg" : "png");
				
				$thumbname = sprintf("%s_thumb.%s", $base_filename, $check_extension);
			
				$file_check = $this->mmhclass->funcs->file_exists($this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$thumbname);
			
				return (($file_check == true || $file_check == false && $this->mmhclass->info->config['thumbnail_type'] == $check_thumbtype) ? $thumbname : sprintf("%s_thumb.%s", $base_filename, $real_extension));
			}
		}
		
		function format_filesize($filesize = 0, $returnbytes = false)
		{
			// Prior to Mihalism Multi Host 5.0.3 this entire function
			// was squeezed into 2 lines. Imagine debugging that. No fun.
			
			while (($filesize / 1024) >= 1) { 
				$filesize_count++; 
				$filesize = ($filesize / 1024); 
			} 
			
			$filesize_count = (($filesize_count < 0) ? 0 : $filesize_count);
			
			if ($returnbytes == true) {
				return array("f" => $filesize, "c" => $filesize_count);
			} else {
				$finalsize = substr($filesize, 0, (strpos($filesize, ".") + 4));
				$finalname = (($filesize > 0.9 && $filesize < 2.0) ? $this->mmhclass->lang['3103'][$filesize_count] : $this->mmhclass->lang['4191'][$filesize_count]);
				
				return (($filesize < 0 || $filesize_count > 9) ? $this->mmhclass->lang['5454'] : sprintf("%s %s", $finalsize, $finalname));
			}
		}
		
		function get_image_info($filename, $querydb = false) 
		{							 
			if ($this->is_image($filename) == false) {
				return false;
			} else {
				$base_filename = $this->basename($filename);
					
				if ($querydb == true) {
					$file_logs = $this->mmhclass->db->fetch_array($this->mmhclass->db->query("SELECT * FROM `[1]` WHERE `filename` = '[2]' LIMIT 1;", array(MYSQL_FILE_LOGS_TABLE, $base_filename)));
					$file_sinfo = $this->mmhclass->db->fetch_array($this->mmhclass->db->query("SELECT * FROM `[1]` WHERE `filename` = '[2]' LIMIT 1;", array(MYSQL_FILE_STORAGE_TABLE, $base_filename)));
					$rating_info = $this->mmhclass->db->fetch_array($this->mmhclass->db->query("SELECT * FROM `[1]` WHERE `filename` = '[2]' LIMIT 1;", array(MYSQL_FILE_RATINGS_TABLE, $base_filename)));
				}
				
				if ($this->manipulator == "imagick") {
					$imageh = new Imagick("{$filename}[0]");
					
					return array(
						"logs" => $file_logs,
						"sinfo" => $file_sinfo,
						"rating" => $rating_info,
						"filename" => $base_filename, 
						"mtime" => filemtime($filename),
						"type" => $imageh->getImageType(),
						"bits" => $imageh->getImageLength(),
						"width" => $imageh->getImageWidth(),
						"height" => $imageh->getImageHeight(),
						"extension" => $this->file_extension($filename),
						"thumbnail" => $this->thumbnail_name($filename),
						"comment" => $imageh->getImageProperty("comment"),
						"mime" => sprintf("image/%s", strtolower($imageh->getImageFormat())),
						"html" => sprintf("width=\"%spx;\" height=\"%spx;\"", $imageh->getImageWidth(), $imageh->getImageHeight()),
					);
				} else {
					$base_info = getimagesize($filename);
					
					return array(
						"logs" => $file_logs,
						"sinfo" => $file_sinfo,
						"rating" => $rating_info,
						"type" => $base_info['2'],
						"html" => $base_info['3'],
						"width" => $base_info['0'],
						"height" => $base_info['1'],
						"mime" => $base_info['mime'],
						"filename" => $base_filename, 
						"bits" => filesize($filename),
						"mtime" => filemtime($filename),
						"extension" => $this->file_extension($filename),
						"thumbnail" => $this->thumbnail_name($filename),
						"comment" => NULL, // Why do we bother declaring this in GD? GD is not advanced enough for it.
					);
				}
			}
		}
		
		function scale($filename, $width = 500, $height = 500, $fillpath = true, $scaletype = NULL) 
		{
			$filename = (($fillpath == false) ? $filename : $this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$filename);
			
			$imageinfo = $this->get_image_info($filename);
			
			switch ($scaletype) {
				case "maxwidth":
					if ($imageinfo['width'] > $width) {
						if ($imageinfo['width'] > $imageinfo['height']) {
							$image_width = $width;
							$image_height = (($imageinfo['height'] * $width) / $imageinfo['width']);
						} elseif ($imageinfo['width'] < $imageinfo['height']) {
							$image_width = (($imageinfo['width'] * $width) / $imageinfo['height']);
							$image_height = $width;
						} elseif ($imageinfo['height'] == $imageinfo['width']) {
							$image_height = $image_height = $width;
						}
						
						return array("w" => $image_width, "h" => $image_height);
					}
					break;
				case "maxheight":
					if ($imageinfo['height'] > $height) {
						if ($imageinfo['width'] > $height) {
							$image_width = $imageinfo['width'];
							$image_height = (($height * $height) / $imageinfo['width']);
						} elseif ($imageinfo['width'] < $height) {
							$image_width = (($imageinfo['width'] * $imageinfo['width']) / $height);
							$image_height = $height;
						} elseif ($height == $imageinfo['width']) {
							$image_width = $imageinfo['width'];
							$image_height = $height;
						}
						
						return array("w" => $image_width, "h" => $image_height);
					}
					break;
				default:
					if ($imageinfo['width'] > $width || $imageinfo['height'] > $height) {
						if ($imageinfo['width'] > $imageinfo['height']) {
							$image_width = $width;
							$image_height = (($imageinfo['height'] * $height) / $imageinfo['width']);
						} elseif ($imageinfo['width'] < $imageinfo['height']) {
							$image_width = (($imageinfo['width'] * $width) / $imageinfo['height']);
							$image_height = $height;
						} elseif ($imageinfo['height'] == $imageinfo['width']) {
							$image_width = $width;
							$image_height = $height;
						}
						
						return array("w" => $image_width, "h" => $image_height);
					}
			}
			
			// No scale returned by now?
			// If not, return something.
			
			return array("w" => $imageinfo['width'], "h" => $imageinfo['height']);
		}
		
		// Only reason I kept the scaleby_* functions was
		// because when I coded scale() I was feeling lazy. :-)
		
		function scaleby_maxwidth($filename, $width = 500, $fillpath = true) 
		{
			return $this->scale($filename, $width, NULL, $fillpath, "maxwidth");		
		}
		
		function scaleby_maxheight($filename, $height = 500, $fillpath = true) 
		{
			return $this->scale($filename, NULL, $height, $fillpath, "maxheight");	
		}

		// A lot of code, for thumbnails. 
		
		function create_thumbnail($filename, $save2disk = true, $resize_type = 0)
		{
			$filename = $this->basename($filename);
				
			if ($this->is_image($this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$filename) == true) {
				$extension = $this->file_extension($filename);
				$thumbnail = $this->thumbnail_name($filename);
				
				if ($save2disk == true) {
					// Seemed easier to build the image resize upload  
					// option into the already established thumbnail function 
					// instead of waisting time trying to chop it up for new one.
					
					if ($resize_type > 0 && $resize_type <= 8) {
						$thumbnail = $filename;
						
						$this->mmhclass->info->config['advanced_thumbnails'] = false;
					
						$size_values = array(
							1 => array("w" => 100, "h" => 75),
							2 => array("w" => 150, "h" => 112),
							3 => array("w" => 320, "h" => 240),
							4 => array("w" => 640, "h" => 480),
							5 => array("w" => 800, "h" => 600),
							6 => array("w" => 1024, "h" => 768),
							7 => array("w" => 1280, "h" => 1024),
							8 => array("w" => 1600, "h" => 1200),	
						);
						
						$thumbnail_size = $size_values[$resize_type];
					} else {
						$thumbnail_size = $this->scale($filename, $this->mmhclass->info->config['thumbnail_width'], $this->mmhclass->info->config['thumbnail_height']);
					}
					
					if ($this->manipulator == "imagick") {
						// New Design of Advanced Thumbnails created by: IcyTexx - http://www.hostili.com
						// Classic Design of Advanced Thumbnails created by: Mihalism Technologies - http://www.mihalism.net
						
						$canvas = new Imagick();
						$athumbnail = new Imagick();
						
						$imagick_version = $canvas->getVersion();
						
						// Imagick needs to start giving real version number, not build number.
						$new_thumbnails = ((version_compare($imagick_version['versionNumber'], "1621", ">=") == true) ? true : false);
						
						$athumbnail->readImage("{$this->mmhclass->info->root_path}{$this->mmhclass->info->config['upload_path']}{$filename}[0]");
					
						$athumbnail->flattenImages();
						$athumbnail->orgImageHeight = $athumbnail->getImageHeight();
						$athumbnail->orgImageWidth = $athumbnail->getImageWidth();
						$athumbnail->orgImageSize = $athumbnail->getImageLength();
						$athumbnail->thumbnailImage($thumbnail_size['w'], $thumbnail_size['h']);
						
						if ($this->mmhclass->info->config['advanced_thumbnails'] == true) {
							$thumbnail_filesize = $this->format_filesize($athumbnail->orgImageSize, true);
							$resobar_filesize = (($thumbnail_filesize['f'] < 0 || $thumbnail_filesize['c'] > 9) ? $this->mmhclass->lang['5454'] : sprintf("%s%s", round($thumbnail_filesize['f']), $this->mmhclass->lang['7071'][$thumbnail_filesize['c']]));
	
							if ($new_thumbnails == true) {
								$textdraw = new ImagickDraw();
								$textdrawborder = new ImagickDraw();
							
								if ($athumbnail->getImageWidth() > 113) {
									$textdraw->setFillColor(new ImagickPixel("white"));
									$textdraw->setFontSize(9);
									$textdraw->setFont("{$mmhclass->info->root_path}css/fonts/sf_fedora_titles.ttf");
									$textdraw->setFontWeight(900);
									$textdraw->setGravity(8);
									$textdraw->setTextKerning(1);
									$textdraw->setTextAntialias(false);
									
									$textdrawborder->setFillColor(new ImagickPixel("black"));
									$textdrawborder->setFontSize(9);
									$textdrawborder->setFont("{$mmhclass->info->root_path}css/fonts/sf_fedora_titles.ttf");
									$textdrawborder->setFontWeight(900);
									$textdrawborder->setGravity(8);
									$textdrawborder->setTextKerning(1);
									$textdrawborder->setTextAntialias(false);
									
									$array_x = array("-1", "0", "1", "1", "1", "0", "-1", "-1");
									$array_y = array("-1", "-1", "-1", "0", "1", "1", "1", "0");
									
									foreach ($array_x as $key => $value) {
										$athumbnail->annotateImage($textdrawborder, $value, (3 - $array_y[$key]), 0, "{$athumbnail->orgImageWidth}x{$athumbnail->orgImageHeight} - {$resobar_filesize}");
									}

									$athumbnail->annotateImage($textdraw, 0, 3, 0, "{}x{$athumbnail->orgImageHeight} - {$resobar_filesize}");
								}
							} else {
								$transback = new Imagick();
								$canvasdraw = new ImagickDraw();
							
								$canvas->newImage($athumbnail->getImageWidth(), ($athumbnail->getImageHeight() + 12), new ImagickPixel("black"));
								$transback->newImage($canvas->getImageWidth(), ($canvas->getImageHeight() - 12), new ImagickPixel("white"));
								
								$canvas->compositeImage($transback, 40, 0, 0);
								$canvasdraw->setFillColor(new ImagickPixel("white"));
								$canvasdraw->setGravity(8);
								$canvasdraw->setFontSize(10);
								$canvasdraw->setFontWeight(900);
								$canvasdraw->setFont("AvantGarde-Demi");
								$canvas->annotateImage($canvasdraw, 0, 0, 0, "{$athumbnail->orgImageWidth}x{$athumbnail->orgImageHeight} - {$resobar_filesize}");
								$canvas->compositeImage($athumbnail, 40, 0, 0); 
								
								$athumbnail = $canvas->clone();
							}
						}
						
						if ($this->mmhclass->info->config['thumbnail_type'] == "jpeg") {
							$athumbnail->setImageFormat("jpeg");
							$athumbnail->setImageCompression(9);
						} else {	
							$athumbnail->setImageFormat("png"); 
						}
						
						$athumbnail->writeImage($this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$thumbnail);
					} else {
						// I hate GD. Piece of crap supports nothing. NOTHING!
						
						if (in_array($extension, array("png", "gif", "jpg", "jpeg")) == true) {	
							$function_extension = str_replace("jpg", "jpeg", $extension);
							$image_function = "imagecreatefrom{$function_extension}";
							
							$image = $image_function($this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$filename);
							$imageinfo = $this->get_image_info($this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$this->basename($filename));
							
							$thumbnail_image = imagecreatetruecolor($thumbnail_size['w'], $thumbnail_size['h']);
							imagecolortransparent($thumbnail_image, imagecolorallocate($thumbnail_image, 0, 0, 0));
							
							imagealphablending($thumbnail_image, false);
							imagesavealpha($thumbnail_image, true);
							
							imagecopyresized($thumbnail_image, $image, 0, 0, 0, 0, $thumbnail_size['w'], $thumbnail_size['h'], $imageinfo['width'], $imageinfo['height']);
							$image_savefunction = sprintf("image%s", (($this->mmhclass->info->config['thumbnail_type'] == "jpeg") ? "jpeg" : "png"));
							
							$image_savefunction($thumbnail_image, $this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$thumbnail);
							chmod($this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$thumbnail, 0644);
							
							imagedestroy($image);	
							imagedestroy($thumbnail_image); 
						} else {
							trigger_error("Image format not supported by GD", E_USER_ERROR);
						}
					}
					
					chmod($this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$thumbnail, 0644);
				} else {
					readfile($this->mmhclass->info->root_path.$this->mmhclass->info->config['upload_path'].$thumbnail);
				}
			}
		}
	}
	
?>