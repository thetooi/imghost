<!-- BEGIN: USER REGISTRATION PAGE -->
<template id="registration_page">

<form action="users.php?act=register-d" method="post">
	<input type="hidden" name="return" value="<# RETURN_URL #>" />
    
  	<div class="table_border">
        <table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
            <tr>
                <th colspan="2">Register at <# SITE_NAME #></th>
            </tr>
            <tr>
                <td style="width: 30%;" class="tdrow1"><span>Username:</span> <br /> <div class="explain">Please enter an username that is 3 to 30 characters in length and only contain the characters: <p class="help" title="-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789">-_A-Za-z0-9</p>. The username that you pick cannot be changed later.</div></td> 
                <td class="tdrow2" valign="top">
                    <input type="text" name="username" id="username_field" class="input_field" style="width: 300px;" maxlength="30" />
                    <br /><br />
                    <div id="username_check"><a href="javascript:void(0);" onclick="check_username();">Check Availability</a></div>
                </td>
            </tr>
            <tr>
                <td style="width: 30%;" class="tdrow1"><span>Password:</span> <br /> <div class="explain">Please enter a password that is 6 to 30 characters in length. It is also recommended to randomize the password for enhanced security. <a href="http://www.whatsmyip.org/passwordgen/" target="_blank">Password Generator</a></div></td> 
                <td class="tdrow2" valign="top"><input type="password" name="password" class="input_field" style="width: 300px;" maxlength="30" /></td>
            </tr>
            <tr>
                <td style="width: 30%;" class="tdrow1"><span>Password (retype):</span></td> 
                <td class="tdrow2"><input type="password" name="password-c" class="input_field" style="width: 300px;" /></td>
            </tr>
            <tr>
                <td style="width: 30%;" class="tdrow1"><span>E-Mail Address:</span> <br /> <div class="explain">This is the E-Mail Address at which we will contact you when changes happen to our services that may affect your account. Please read our <a href="info.php?act=privacy_policy" target="_blank">Privacy Policy</a>.</div></td> 
                <td class="tdrow2" valign="top"><input type="text" class="input_field" name="email_address" style="width: 300px;" /></td>
            </tr>
            <tr>
                <td style="width: 30%;" class="tdrow1" valign="top"><span>Security Code:</span></td> 
                <td class="tdrow2"><# CAPTCHA_CODE #></td>
            </tr>
            <tr>
                <td class="tdrow2" colspan="2" style="height: 35px;">
                	<div class="text_align_center">
       	            	<input type="checkbox" name="iagree" id="iagree" value="1" /> <label for="iagree">By clicking "Finish Registration" I understand the <a href="info.php?act=privacy_policy">Privacy Policy</a> and <a href="info.php?act=rules">Terms of Service</a>.</label>
                	</div>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="table_footer"><input type="submit" value="Finish Registration" class="button1" /></td>
            </tr>
        </table>
  	</div>
</form>

</template>
<!-- END: USER REGISTRATION PAGE -->

<!-- BEGIN: USER REGISTRATION HARD LIMIT EMAIL -->
<template id="user_registration_hard_limit">

<# SITE_NAME #> Administrator,
<br /><br />
The hard limit of 5 user accounts per IP address has<br />
been exceeded by the user with the IP address: <a href="http://whois.domaintools.com/<# IP_ADDRESS #>"><# IP_ADDRESS #></a>.
<br /><br />
To take action, log in to the Admin Control Panel at:
<br /><br />
<# BASE_URL #>admin.php

</template>
<!-- END: USER REGISTRATION HARD LIMIT EMAIL -->

<!-- BEGIN: USER LOGIN LIGHTBOX -->
<template id="login_lightbox">

<form action="users.php?act=login-d" method="post">
	<input type="hidden" name="return" value="<# RETURN_URL #>" />
    
	<table cellpadding="4" cellspacing="1" border="0" style="width: 100%; background: #ebf1f5;">
		<tr>
            <th colspan="2">Log In</th>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td class="text_align_right" style="width: 45%;"><span>Username</span>:&nbsp;</td> 
            <td><input type="text" name="username" class="input_field" style="width: 200px;" /></td>
        </tr>
        <tr>
         	<td class="text_align_right" style="width: 45%;"><span>Password</span>:&nbsp;</td>
            <td><input type="password" name="password" class="input_field" style="width: 200px;" /></td>
        </tr>
        <tr>
            <td class="text_align_center" style="height: 45px;" colspan="2">
            	<input type="submit" value="Log In" class="button1" />
           	</td>
        </tr>
        <tr>
            <td class="text_align_center" style="font-size: 10px;" colspan="2">
                ( <a href="javascript:void(0);" onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>'); toggle_lightbox('users.php?act=lost_password', 'lost_password_lightbox');">Reset Password</a> | 
                <a href="users.php?act=register&amp;return=<# RETURN_URL #>">Register</a> )
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        <tr>
            <td class="table_footer" colspan="2"><a onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');">Close Window</a></td>
        </tr>
    </table>
</form>

</template>
<!-- END: USER LOGIN LIGHTBOX -->

<!-- BEGIN: FORGOTTEN PASSWORD LIGHTBOX -->
<template id="forgotten_password_lightbox">

<form action="users.php?act=lost_password-d" method="post">
	<table cellpadding="4" cellspacing="1" border="0" style="width: 100%; background: #ebf1f5;">
		<tr>
			<th colspan="2">Reset My Password</th>
		</tr>
		<tr>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td class="text_align_right" style="width: 45%;"><span>Username</span>:&nbsp;</td> 
			<td><input type="text" name="username" class="input_field" style="width: 200px;" /></td>
		</tr>
		<tr>
			<td class="text_align_right" style="width: 45%;"><span>E-Mail Address</span>:&nbsp;</td> 
			<td><input type="text" name="email_address" class="input_field" style="width: 200px;" /></td>
		</tr>
		<tr>
			<td colspan="2" class="text_align_center" style="height: 45px;">
            	<input type="submit" value="Send Password" class="button1" />
          </td>
		</tr>
		<tr>
			<td colspan="2" class="table_footer"><a onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');">Close Window</a></td>
		</tr>
	</table>
</form>

</template>
<!-- END: FORGOTTEN PASSWORD LIGHTBOX -->

<!-- BEGIN: FORGOTTEN PASSWORD EMAIL -->
<template id="forgotten_password_email">

Hello <# USERNAME #>,
<br /><br />
You are receiving this email because you have (or someone pretending to be you has) requested<br />
a new password be set for your account on <a href="<# BASE_URL #>"><# SITE_NAME #></a>. If you did not request this email,<br />
then please ignore it, and if you keep receiving it, then please <a href="<# BASE_URL #>contact.php?act=contact_us">contact the site administrator</a>.
<br /><br />
To use the new password you need to activate it. To do this click the link provided below.
<br /><br />
<a href="<# BASE_URL #>users.php?act=lost_password-a&id=<# AUTH_KEY #>">Activate New Password</a>
<br /><br />
If successful you will be able to log in using the following information:
<br /><br />
<strong>Username:</strong> <# USERNAME #><br />
<strong>Password:</strong> <# NEW_PASSWORD #>
<br /><br />
<em>Please keep in mind that the password you enter is case sensitive.</em>
<br /><br />
----<br />
<# SITE_NAME #> Support<br />
<# ADMIN_EMAIL #>

</template>
<!-- END: FORGOTTEN PASSWORD EMAIL -->

<!-- BEGIN: USER LIST PAGE -->
<template id="user_list_page">

<# PAGINATION_LINKS #>
<br /><br />

<div class="table_border">
	<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
		<tr>
			<th>Username</th>
			<th>Date Registered</th>
			<th>Gallery Status</th>
			<th>Total Uploads</th>
			<th>&nbsp;</th>
		</tr>
        
		<while id="user_list_whileloop">
			<tr>
				<td class="<# TDCLASS #>"><a href="users.php?act=gallery&amp;gal=<# USER_ID #>"><# USERNAME #></a></td>
				<td class="<# TDCLASS #>"><# TIME_JOINED #></td>
				<td class="<# TDCLASS #>"><# GALLERY_STATUS #></td>
				<td class="<# TDCLASS #>"><# TOTAL_UPLOADS #></td>
				<td class="<# TDCLASS #>"><a href="users.php?act=gallery&amp;gal=<# USER_ID #>">View Gallery</a></td>
			</tr>
		</endwhile>
        
		<tr>
			<td colspan="5" class="table_footer">&nbsp;</td>
		</tr>
	</table>
</div>

</template>
<!-- END: USER LIST PAGE -->

<!-- BEGIN: MY GALLERY PAGE -->
<template id="my_gallery_page">

<div class="align_left_mfix">
    <ul class="jd_menu">
        <if="$mmhclass->info->user_owned_gallery == true">
     		<li><span onclick="gallery_action('delete');" title="Delete Selected" class="button1">Delete Images</span></li>
            <li><span onclick="gallery_action('move');" title="Move Selected" class="button1">Move Images</span></li>
      		<li><span onclick="gallery_action('select');" title="Select/Deselect All" class="button1">Select All</span></li>
        </endif>
        
      	<li><span class="button1">Album List</span>
            <ul class="menu_border">
                <if="$mmhclass->info->user_owned_gallery == true">
                    <li class="header">Actions</li>
                    <li class="item"><a href="javascript:void(0);" onclick="toggle_lightbox('users.php?act=albums-c', 'new_album_lightbox');">New Album</a></li>
                </endif>
                
                <li class="header">Albums</li>
                <li class="item"><a href="<# GALLERY_URL #>">Root Album</a> (<# TOTAL_ROOT_UPLOADS #> of <# TOTAL_UPLOADS #> images)</li>
                
                <while id="album_pulldown_whileloop">
                    <li class="item"> 
                        <strong>&bull;</strong> <a href="<# GALLERY_URL #>&amp;cat=<# ALBUM_ID #>"><# ALBUM_NAME #></a> (<# TOTAL_UPLOADS #> images) 
                       
                        <if="$mmhclass->info->user_owned_gallery == true">
                            ( <a href="javascript:void(0);" onclick="toggle_lightbox('users.php?act=albums-d&amp;album=<# ALBUM_ID #>', 'delete_album_lightbox');">Delete</a> |
                            <a href="javascript:void(0);" onclick="toggle_lightbox('users.php?act=albums-r&amp;album=<# ALBUM_ID #>', 'rename_album_lightbox');">Rename</a> )
                        </endif>
                    </li>
                </endwhile>
      		</ul>
      	</li>
        
        <if="$mmhclass->funcs->is_null($mmhclass->input->get_vars['search']) == true">
            <li><span class="button1">Search</span>
                <ul class="menu_border">
                    <li class="header">Search this Album</li>
                    <li class="item text_align_center">
                        <input type="text" id="file_search" class="input_field" maxlength="25" style="width: 130px;" value="Enter Filename or Title" onclick="$(this).val('');" onkeydown="if(event.keyCode==13){$('input[id=file_search_button]').click();}" />
                        <input type="button" value="Go" id="file_search_button" onclick="location.href=('<# FULL_GALLERY_URL #>&amp;search=' + encodeURIComponent($('input[id=file_search]').val()));" />
                        <br /><br />
                        <b>%</b> and <b>_</b> are <a href="http://dev.mysql.com/doc/refman/5.0/en/string-comparison-functions.html#operator_like" target="_blank">wildcard characters</a>.
                    </li>
                </ul>
            </li>
        <else>
        	<li><a href="<# FULL_GALLERY_URL #>" class="button1">Clear Search</a></li>
        </endif>
    </ul>
</div>

<# PAGINATION_LINKS #>
<br /><br />

<if="$mmhclass->templ->templ_globals['empty_gallery'] == true">
	<# EMPTY_GALLERY #>
<else>
    <div class="table_border">
        <table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
            <tr>
	            <th colspan="4">
            		<if="$mmhclass->funcs->is_null($mmhclass->input->get_vars['search']) == true">
               			<# GALLERY_OWNER #>'s Gallery <# ALBUM_NAME #>
      				<else>
                    	Searching for "<# IMAGE_SEARCH #>"
                	</endif>
                </th>
            </tr>
            <tr>
                <# GALLERY_HTML #>
            </tr>
            <tr>
                <td colspan="4" class="table_footer">&nbsp;</td>
            </tr>
        </table>
    </div>
    
    <div class="pagination_footer">
        <# PAGINATION_LINKS #>
    </div>
</endif>

</template>
<!-- END: MY GALLERY PAGE -->

<!-- BEGIN: MOVE FILES LIGHTBOX -->
<template id="move_files_lightbox">

<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
	<tr>
		<th>Move Images</th>
	</tr>
	<tr>
		<td class="tdrow1 text_align_center">
			<br />
			<form action="users.php?act=move_files-d" method="post">
				<p>
					<b>Move To</b>:
					<br /><br />
                    
					<select name="move_to" style="width: 200px;">
						<option value="root">Root Album</option>
                        
						<while id="album_options_whileloop">
							<option value="<# ALBUM_ID #>">&bull; <# ALBUM_NAME #></option>
						</endwhile>
					</select>
					<br /><br />
                    
					<input type="hidden" value="<# FILES2MOVE #>" name="files" />
					<input type="hidden" value="<# RETURN_URL #>" name="return" />
                    
					<input type="submit" value="Move Images" class="button1" />
					<input type="button" value="Cancel" class="button1" onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');" />
				</p>
			</form>
			<br /><br />
		</td>
	</tr>
	<tr>
		<td class="table_footer"><a onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');">Close Window</a></td>
	</tr>
</table>

</template>
<!-- END: MOVE FILES LIGHTBOX -->

<!-- BEGIN: DELETE FILES LIGHTBOX -->
<template id="delete_files_lightbox">

<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
	<tr>
		<th>Confirm Image Deletion</th>
	</tr>
	<tr>
		<td class="tdrow1 text_align_center">
			<br />
			<form action="users.php?act=delete_files-d" method="post">
				<p>
					Are you sure you wish to carry out this operation? 
					<br /><br />
					If you select "Yes" there is no undo.
					<br /><br />
                    
					<input type="hidden" value="<# RETURN_URL #>" name="return" />
					<input type="hidden" value="<# FILES2DELETE #>" name="files" />
                    
					<input type="submit" value="Yes" class="button1" />
					<input type="button" value="No" class="button1" onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');" />
				</p>
			</form>
			<br /><br />
		</td>
	</tr>
	<tr>
		<td class="table_footer"><a onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');">Close Window</a></td>
	</tr>
</table>

</template>
<!-- END: DELETE FILES LIGHTBOX -->

<!-- BEGIN: NEW ALBUM LIGHTBOX -->
<template id="new_album_lightbox">

<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
	<tr>
		<th>New Album</th>
	</tr>
	<tr>
		<td class="tdrow1 text_align_center">
			<br />
			<form action="users.php?act=albums-c-d" method="post">
				<p>
					<b>Album Title</b>:
					<br /><br />
                    
					<input type="text" name="album_title" maxlength="50" class="input_field" style="width: 250px;" />
					<br /><br />
                    
					<input type="hidden" value="<# RETURN_URL #>" name="return" />
                    
					<input type="submit" value="Create Album" class="button1" />
					<input type="button" value="Cancel" class="button1" onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');" />
				</p>
			</form>
			<br /><br />
		</td>
	</tr>
	<tr>
		<td class="table_footer"><a onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');">Close Window</a></td>
	</tr>
</table>

</template>
<!-- END: NEW ALBUM LIGHTBOX -->

<!-- BEGIN: RENAME ALBUM LIGHTBOX -->
<template id="rename_album_lightbox">

<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
	<tr>
		<th>Rename Album</th>
	</tr>
	<tr>
		<td class="tdrow1 text_align_center">
			<br />
			<form action="users.php?act=albums-r-d" method="post">
				<p>
					<b>New Album Title</b>:
					<br /><br />
                    
					<input type="text" name="album_title" maxlength="50" class="input_field" style="width: 250px;" value="<# OLD_TITLE #>" onclick="$(this).val('');" />
					<br /><br />
                    
					<input type="hidden" value="<# ALBUM_ID #>" name="album" />
					<input type="hidden" value="<# RETURN_URL #>" name="return" />
                    
					<input type="submit" value="Rename Album" class="button1" />
					<input type="button" value="Cancel" class="button1" onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');" />
				</p>
	    	</form>
			<br /><br />
		</td>
	</tr>
	<tr>
		<td class="table_footer"><a onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');">Close Window</a></td>
	</tr>
</table>

</template>
<!-- END: RENAME ALBUM LIGHTBOX -->

<!-- BEGIN: DELETE ALBUM LIGHTBOX -->
<template id="delete_album_lightbox">

<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
	<tr>
		<th>Confirm Album Deletion</th>
	</tr>
	<tr>
		<td class="tdrow1 text_align_center">
			<br />
			<form action="users.php?act=albums-d-d" method="post">
				<p>
					Are you sure you wish to carry out this operation? 
					<br /><br />
					If you select "Yes" there is no undo.
					<br /><br />
                    
					<input type="hidden" value="<# ALBUM2DELETE #>" name="album" />
                    
					<input type="submit" value="Yes" class="button1" />
					<input type="button" value="No" class="button1" onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');" />
                    <br /><br />
                    
					<div style="font-size: 10px; font-style: italic;">
                    	<strong>Note:</strong> Images within this album will be moved to the root album, not deleted.
                    </span>
				</p>
			</form>
			<br /><br />
		</td>
	</tr>
	<tr>
		<td class="table_footer"><a onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');">Close Window</a></td>
	</tr>
</table>

</template>
<!-- END: DELETE ALBUM LIGHTBOX -->

<!-- BEGIN: USER SETTINGS PAGE -->
<template id="user_settings_page">

<form action="users.php?act=settings-s" method="post">
	<div class="table_border">
		<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
			<tr>
				<th colspan="2">User Settings</th>
			</tr>
			<tr>
				<td class="tdrow1" style="width: 38%;"><span>User ID</span>:</td>
				<td class="tdrow2"><# USER_ID #></td>
			</tr>
			<tr>
				<td class="tdrow1" style="width: 38%;"><span>Username</span>:</td>
				<td class="tdrow2"><# USERNAME #></td>
			</tr>
			<tr>
				<td class="tdrow1" style="width: 38%;" valign="top"><span>Password</span>: <br /> <div class="explain">Please enter a password that is 6 to 30 characters in length. It is also recommended to randomize the password for enhanced security. To create a secure random password try the <a href="http://whatsmyip.org/passwordgen/" target="_blank">Password Generator</a>.</div></td>
				<td class="tdrow2" valign="top"><input type="password" style="width: 300px;" class="input_field" name="password" maxlength="30" value="*************" /></td>
			</tr>
			<tr>
				<td class="tdrow1" style="width: 38%;"><span>IP Address</span>:</td>
				<td class="tdrow2"><p title="<# IP_HOSTNAME #>" class="help"><# IP_ADDRESS #></p> ( <a href="http://whois.domaintools.com/<# IP_ADDRESS #>" target="_blank">Whois</a> | <a href="http://just-ping.com/index.php?vh=<# IP_ADDRESS #>" target="_blank">Ping</a> )</td>
			</tr>
			<tr>
				<td class="tdrow1" style="width: 38%;"><span>E-Mail Address</span>: <br /> <div class="explain">This is the E-Mail Address at which we will contact you when changes happen to our services that may affect your account.</div></td>
				<td class="tdrow2" valign="top"><input type="text" style="width: 300px;" name="email_address" class="input_field" value="<# EMAIL_ADDRESS #>" /></td>
			</tr>
			<tr>
				<td class="tdrow1" style="width: 38%"><span>Private Gallery</span>: <br /> <div class="explain">Enabling this option will make it so only you or a site administrator can view your entire gallery. If disabled, then during uploading you can choose to make the images being uploaded private or not.</div></td>
				<td class="tdrow2" valign="top"><input type="radio" name="private_gallery" value="1" <# PRIVATE_GALLERY_YES #> /> Yes <input type="radio" name="private_gallery" value="0" <# PRIVATE_GALLERY_NO #> /> No</td>
			</tr>
			<tr>
				<td class="tdrow1" style="width: 38%;"><span>Default Upload Layout</span>:</td>
				<td class="tdrow2"><input type="radio" name="upload_type" value="standard" <# STANDARD_UPLOAD_YES #> /> <p onclick="toggle_lightbox('index.php?layoutprev=std', 'upload_layout_preview_lightbox');" title="Click to preview" class="help">Standard</p> <input type="radio" name="upload_type" value="boxed" <# BOXED_UPLOAD_YES #> /> <p onclick="toggle_lightbox('index.php?layoutprev=bx', 'upload_layout_preview_lightbox');" title="Click to preview" class="help">Boxed</p></td>
			</tr>
			<tr>
				<td class="tdrow1" style="width: 38%;"><span>Date Registered</span>:</td>
				<td class="tdrow2"><# TIME_JOINED #></td>
			</tr>
			<tr>
				<td class="tdrow1" style="width: 38%;"><span>User Group</span>:</td>
				<td class="tdrow2"><# USER_GROUP #></td>
			</tr>
			<tr>
				<td class="table_footer" colspan="2"><input type="submit" value="Save Settings" class="button1" /></td>
			</tr>
		</table>
	</div>
</form> 

</template>
<!-- END: USER SETTINGS PAGE -->