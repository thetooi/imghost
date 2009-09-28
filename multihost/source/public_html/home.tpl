
<!-- BEGIN: NORMAL UPLOAD PAGE -->
<template id="normal_upload_page">

Welcome to <# SITE_NAME #>, a free image upload solution. Simply browse, select, and upload!
<br /><br />	
Select an image file to upload - <a href="index.php?url=1">URL Upload</a><br />
Max filesize is set at: <# MAX_FILESIZE #> per image file.
<br /><br />

<form action="upload.php" method="post" id="upload_form" enctype="multipart/form-data">
	<p>
		<input name="userfile[]" type="file" size="50" /> <br />
		<input name="userfile[]" type="file" size="50" /> <br />
		<input name="userfile[]" type="file" size="50" /> <br />
		<input name="userfile[]" type="file" size="50" /> <br />
		<input name="userfile[]" type="file" size="50" /> <br />
        
		<span id="more_file_inputs"></span> <br />
        
        <div id="upoptions_hidden">
       		<img src="css/images/arrowhide.png" alt="Show Available Options" onclick="toggle('upoptions_hidden'); toggle('upoptions_shown');" />
        	Uploading Options: <a href="javascript:void(0);" onclick="toggle('upoptions_hidden'); toggle('upoptions_shown');">Show Available Options</a>
        </div>
        
        <div id="upoptions_shown" style="display: none;">
       		<img src="css/images/arrowshow.png" alt="Hide Available Options" onclick="toggle('upoptions_hidden'); toggle('upoptions_shown');" />
            Uploading Options: <a href="javascript:void(0);" onclick="toggle('upoptions_hidden'); toggle('upoptions_shown');">Hide Available Options</a>
            <br /><br />
            
            <div id="upload_options">
                <if="$mmhclass->info->is_user == false || $mmhclass->info->is_user == true && $mmhclass->info->user_data['private_gallery'] == false">
                    &bull; Upload Type: <input type="radio" name="private_upload" value="0" checked="checked" /> Public <input type="radio" name="private_upload" value="1" /> Private
                    <br /><br />
                </endif>
                
                &bull; Output Layout: <input type="radio" name="upload_type" value="standard" <# STANDARD_UPLOAD_YES #> /> <span onclick="toggle_lightbox('index.php?layoutprev=std', 'upload_layout_preview_lightbox');" title="Click to preview" class="help">Standard</span> <input type="radio" name="upload_type" value="normal-boxed" <# BOXED_UPLOAD_YES #> /> <span onclick="toggle_lightbox('index.php?layoutprev=bx', 'upload_layout_preview_lightbox');" title="Click to preview" class="help">Boxed</span>
                <br /><br />
                
                <if="$mmhclass->info->is_user == true && $mmhclass->templ->templ_globals['hide_upload_to'] == false">
                    &bull; Upload To: 
                    <select name="upload_to" style="width: 220px;">
                        <option value="0" selected="selected">Root Album</option>
                        
                        <while id="albums_pulldown_whileloop">
                            <option value="<# ALBUM_ID #>">&bull; <# ALBUM_NAME #></option>
                        </endwhile>
                    </select>
                    <br /><br />
                </endif>
                
                &bull; Resize Images: 
                <select name="image_resize" style="width: 220px;">
                    <option value="0" selected="selected">Do Not Resize</option>
                    
                    <option disabled="disabled">----</option>
                    
                    <option value="1">100x75 (avatar)</option>
                    <option value="2">150x112 (thumbnail)</option>
                    <option value="3">320x240 (for websites and email)</option>
                    <option value="4">640x480 (for message boards)</option>
                    <option value="5">800x600 (15-inch monitor)</option>
                    <option value="6">1024x768 (17-inch monitor)</option>
                    <option value="7">1280x1024 (19-inch monitor)</option>
                    <option value="8">1600x1200 (21-inch monitor)</option>
                </select>
         	</div>
        </div><br />
        
		<input class="button1" type="button" value="Add More Files" onclick="new_file_input();" /> 
		<input class="button1" type="button" value="Start Uploading" onclick="toggle_lightbox('index.php?act=upload_in_progress', 'progress_bar_lightbox'); $('form[id=upload_form]').submit();" />
	</p>
</form>
<br /><br />

Allowed File Extensions: <# FILE_EXTENSIONS #>

</template>
<!-- END: NORMAL UPLOAD PAGE -->

<!-- BEGIN: URL UPLOAD PAGE -->
<template id="url_upload_page">

<script type="text/javascript">
	function set_upload_type(id)
	{
		$("div[id=upload_types] div:visible").attr("style", "display: none;"); 
		$("div[id=" + $(id).val() + "]").attr("style", "display: block;");	
		
		switch ($(id).val()) {
			case "paste_upload":
				$("input[id=more_files_button]").attr("disabled", "disabled");
				$("span[id=more_instructions]").html("<br />Separate each image URL with a new line.");
				$("span[id=instructions]").html("Enter up to <# MAX_RESULTS #> image file URLs to upload");
				break;
			case "normal_upload":
				$("span[id=more_instructions]").html("&nbsp;");
				$("input[id=more_files_button]").removeAttr("disabled");
				$("span[id=instructions]").html("Enter an image file URL to upload");
				break;
			case "webpage_upload":
				$("input[id=more_files_button]").attr("disabled", "disabled");
				$("span[id=instructions]").html("Enter a webpage URL to upload images from");
				$("span[id=more_instructions]").html("<br />Only the first <# MAX_RESULTS #> images that are found will be uploaded.");
				break;
		}
	}
</script>

Welcome to <# SITE_NAME #>, a free image upload solution. Simply browse, select, and upload!
<br /><br />	
<span id="instructions">Enter an image file URL to upload</span> - <a href="index.php">Normal Upload</a><br />
Max filesize is set at: <# MAX_FILESIZE #> per image file. <span id="more_instructions">&nbsp;</span>
<br /><br />

<form action="upload.php" method="post" id="upload_form" enctype="multipart/form-data">
	<p>
        <div id="upload_types">
        	<div id="normal_upload">
                URL: <input name="userfile[]" type="text" size="55" class="input_field" /> <br />
                URL: <input name="userfile[]" type="text" size="55" class="input_field" /> <br />
                URL: <input name="userfile[]" type="text" size="55" class="input_field" /> <br />
                URL: <input name="userfile[]" type="text" size="55" class="input_field" /> <br />
                URL: <input name="userfile[]" type="text" size="55" class="input_field" /> <br />
				
                <span id="more_file_inputs"></span> <br />
            </div>
            
            <div id="webpage_upload" style="display: none;">
                URL: <input name="webpage_upload" type="text" size="50" class="input_field" value="http://www.google.com/" onclick="$(this).val('');" />
                <br /><br />
            </div>
            
            <div id="paste_upload" style="display: none;">
           		<textarea name="paste_upload" cols="60" rows="10" class="input_field" style="width: 440px;"></textarea>
                <br /><br />
            </div>
        </div>
        
    	URL Upload Type: 
        <select name="url_upload_type" onchange="set_upload_type(this);">
        	<option value="normal_upload">Normal URL Upload</option>
        	<option value="paste_upload">Paste a List of URLs to Upload</option>
        	<option value="webpage_upload">Upload All Images Linked on a Webpage</option>
        </select>
        <br /><br />
        
        <div id="upoptions_hidden">
       		<img src="css/images/arrowhide.png" alt="Show Available Options" onclick="toggle('upoptions_hidden'); toggle('upoptions_shown');" />
        	Uploading Options: <a href="javascript:void(0);" onclick="toggle('upoptions_hidden'); toggle('upoptions_shown');">Show Available Options</a>
        </div>
        
        <div id="upoptions_shown" style="display: none;">
       		<img src="css/images/arrowshow.png" alt="Hide Available Options" onclick="toggle('upoptions_hidden'); toggle('upoptions_shown');" />
       		Uploading Options: <a href="javascript:void(0);" onclick="toggle('upoptions_hidden'); toggle('upoptions_shown');">Hide Available Options</a>
            <br /><br />
            
            <div id="upload_options">
                <if="$mmhclass->info->is_user == false || $mmhclass->info->is_user == true && $mmhclass->info->user_data['private_gallery'] == false">
                    &bull; Upload Type: <input type="radio" name="private_upload" value="0" checked="checked" /> Public <input type="radio" name="private_upload" value="1" /> Private
                    <br /><br />
                </endif>
                
                &bull; Output Layout: <input type="radio" name="upload_type" value="url-standard" <# STANDARD_UPLOAD_YES #> /> <span onclick="toggle_lightbox('index.php?layoutprev=std', 'upload_layout_preview_lightbox');" title="Click to preview" class="help">Standard</span> <input type="radio" name="upload_type" value="url-boxed" <# BOXED_UPLOAD_YES #> /> <span onclick="toggle_lightbox('index.php?layoutprev=bx', 'upload_layout_preview_lightbox');" title="Click to preview" class="help">Boxed</span>
                <br /><br />
                    
                <if="$mmhclass->info->is_user == true && $mmhclass->templ->templ_globals['hide_upload_to'] == false">
                    &bull; Upload to: 
                    <select name="upload_to" style="width: 220px;">
                        <option value="0" selected="selected">Root Album</option>
                        
                        <while id="albums_pulldown_whileloop">
                            <option value="<# ALBUM_ID #>">&bull; <# ALBUM_NAME #></option>
                        </endwhile>
                    </select>
                    <br /><br />
                </endif>
                
                &bull; Resize Images: 
                <select name="image_resize" style="width: 220px;">
                    <option value="0" selected="selected">Do Not Resize</option>
                    
                    <option disabled="disabled">----</option>
                    
                    <option value="1">100x75 (avatar)</option>
                    <option value="2">150x112 (thumbnail)</option>
                    <option value="3">320x240 (for websites and email)</option>
                    <option value="4">640x480 (for message boards)</option>
                    <option value="5">800x600 (15-inch monitor)</option>
                    <option value="6">1024x768 (17-inch monitor)</option>
                    <option value="7">1280x1024 (19-inch monitor)</option>
                    <option value="8">1600x1200 (21-inch monitor)</option>
                </select>
         	</div>
        </div><br />
        
		<input class="button1" type="button" value="Add More Files" onclick="new_file_input('url');" id="more_files_button" /> 
		<input class="button1" type="button" value="Start Uploading" onclick="toggle_lightbox('index.php?act=upload_in_progress', 'progress_bar_lightbox'); $('form[id=upload_form]').submit();" />
	</p>
</form>
<br /><br />

Allowed File Extensions: <# FILE_EXTENSIONS #>

</template>
<!-- END: URL UPLOAD PAGE -->

<!-- BEGIN: UPLOADER PROGRESS BAR LIGHTBOX -->
<template id="upload_in_progress_lightbox">

<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
	<tr>
		<th>Please Stand By</th>
	</tr>
	<tr>
		<td class="tdrow1 text_align_center">
            Upload in progress...
            <br /><br />
            <img src="css/images/progress_bar.gif" alt="Loading..." style="height: 40px;" />
            <br /><br />
            Your images are in the process of being uploaded.
        </td>
	</tr>
	<tr>
		<td class="table_footer">&nbsp;</td>
	</tr>
</table>

</template>
<!-- END: UPLOADER PROGRESS BAR LIGHTBOX -->

<!-- BEGIN: UPLOAD LAYOUT PREVIEW LIGHTBOX -->
<template id="upload_layout_preview_lightbox">

<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
	<tr>
		<th>Upload Layout Preview</th>
	</tr>
	<tr>
		<td class="tdrow1 text_align_center" height="<# IMAGE_HEIGHT #>px;">
			<a href="css/images/<# PREVIEW_TYPE #>layout_prev.png"><img src="css/images/<# PREVIEW_TYPE #>layout_prev.png" alt="Upload Layout Preview" /></a>
        </td>
	</tr>
	<tr>
		<td class="table_footer"><a onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');">Close Window</a></td>
	</tr>
</table>

</template>
<!-- END: UPLOAD LAYOUT PREVIEW LIGHTBOX -->