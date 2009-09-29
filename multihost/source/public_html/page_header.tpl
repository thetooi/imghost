<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-us" xml:lang="en-us">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="Content-Language" content="en-us" />
    <meta http-equiv="imagetoolbar" content="no" />
    
    <title><# PAGE_TITLE #></title>
   
    <meta name="version" content="Mihalism Multi Host v<# VERSION #>" />
    <meta name="description" content="<# SITE_NAME #> is an easy image hosting solution for everyone." />
    <meta name="keywords" content="image hosting, image hosting service, multiple image hosting, unlimited bandwidth, quick image hosting" />
    
    <base href="<# BASE_URL #>" />
    
    <link rel="shortcut icon" href="css/images/favicon.ico" />
    <link href="css/style.css" rel="stylesheet" type="text/css" media="screen" />
    
    <script type="text/javascript" src="source/includes/scripts/jquery.js"></script>
    <script type="text/javascript" src="source/includes/scripts/genjscript.js"></script>
    <script type="text/javascript" src="source/includes/scripts/phpjs_00029.js"></script>
    <script type="text/javascript" src="source/includes/scripts/jquery.jdMenu.js"></script>
    <script type="text/javascript" src="source/includes/scripts/jquery.bgiframe.js"></script>
    <script type="text/javascript" src="source/includes/scripts/jquery.positionBy.js"></script>
    <script type="text/javascript" src="source/includes/scripts/jquery.dimensions.js"></script>
</head>
<body class="page_cell">
	<a href="index.php" style="text-decoration: none;"><div class="logo">&nbsp;</div></a>
    
	<div class="nav_menu">
		<ul>
			<li><a href="index.php">Home</a></li>
			<li><a href="info.php?act=about_us">About Us</a></li>
			<li><a href="info.php?act=rules">Terms of Service</a></li>
			<li><a href="gallery.php">Public Gallery</a></li>
			<li><a href="contact.php?act=file_report">Report Abuse</a></li>
			<li><a href="tools.php">Tools</a></li>
			<li><a href="index.php?do_random=true">Random Image</a></li>
		</ul>
	</div>
    
	<div class="members_bar">
		<if="$mmhclass->info->is_user == true">
			<div class="align_left">
				Logged in as: <a href="users.php?act=gallery"><# USERNAME #></a> 
			</div>
            
			<div class="align_right">
				<if="$mmhclass->info->is_admin == true">
					<a href="admin.php">Admin Control Panel</a> &bull;
				</endif>
                
				<a href="users.php?act=gallery">My Gallery</a> &bull;
				<a href="users.php?act=settings">Settings</a> &bull;
				<a href="users.php?act=logout">Log Out</a>
			</div>
		<else>
			<div class="guest_links">
				Welcome Guest
				( <a href="javascript:void(0);" onclick="toggle_lightbox('users.php?act=login', 'login_lightbox');">Log In</a> | 
				<a href="users.php?act=register&amp;return=<# RETURN_URL #>">Register</a> )
			</div>
		</endif>
	</div>
    
    <if="stripos($mmhclass->input->server_vars['http_user_agent'], "MSIE 6.0") !== false && stripos($mmhclass->input->server_vars['http_user_agent'], "MSIE 8.0") === false && stripos($mmhclass->input->server_vars['http_user_agent'], "MSIE 7.0") === false">
       <div class="slideout_warning">
            <span class="picture ie_picture">&nbsp;</span>
            
            <span class="info">
                <h1>Unsupported Web Browser</h1>
                The web browser that you are running is not supported. 
                Please try one of the following: <a href="http://www.microsoft.com/windows/internet-explorer/default.aspx">Internet Explorer 8</a>, <a href="http://www.apple.com/safari/">Safari</a>, <a href="http://firefox.com">Firefox</a>, or <a href="http://opera.com">Opera</a>.
            </span>
        </div>
    <else>
        <noscript>
           <div class="slideout_warning">
                <span class="picture">&nbsp;</span>
                
                <span class="info">
                    <h1>JavaScript is Disabled!</h1>
                    Your browser currently has JavaScript disabled or does not support it.
                    Since this website uses JavaScript extensively it is recommended to <a href="http://support.microsoft.com/gp/howtoscript">enable it</a>.
                </span>
            </div>
        </noscript>
    </endif>
        
    <div style="clear: both;"></div>
    
	<div id="page_body" class="page_body">