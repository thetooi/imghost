<!-- BEGIN: FILE RESULTS TABLE -->
<template id="standard_file_results">

<table cellpadding="5" cellspacing="0" border="0" style="width: 100%;">
	<tr>
		<td style="width: 20%;" valign="middle" class="text_align_center">
			<a href="<# BASE_URL #>viewer.php?file=<# FILENAME #>"><img src="index.php?module=thumbnail&amp;file=<# FILENAME #>" alt="<# FILENAME #>" <# THUMBNAIL_SIZE #> /></a>
		</td>
        
		<td style="width: 80%;">
			<table cellspacing="1" cellpadding="0" border="0" style="width: 100%;">
				<tr>
					<td><input readonly="readonly" class="input_field" onclick="highlight(this);" type="text" style="width: 605px;" value="<# BASE_URL #><# UPLOAD_PATH #><# FILENAME #>" /></td>
					<td>Direct Link</td>
				</tr>
				<tr>
					<td><input readonly="readonly" class="input_field" onclick="highlight(this);" type="text" style="width: 605px;" value="&lt;a href=&quot;<# BASE_URL #>viewer.php?file=<# FILENAME #>&quot;&gt;&lt;img src=&quot;<# THUMBNAIL #>&quot; border=&quot;0&quot; alt=&quot;<# FILENAME #>&quot; /&gt;&lt;/a&gt;" /></td>
					<td>Thumbnail for Website</td>
				</tr>
				<tr>
					<td><input readonly="readonly" class="input_field" onclick="highlight(this);" type="text" style="width: 605px;" value="[URL=<# BASE_URL #>viewer.php?file=<# FILENAME #>][IMG]<# THUMBNAIL #>[/IMG][/URL]" /></td>
					<td>Thumbnail for Forum</td>
				</tr>
				<tr>
					<td><input readonly="readonly" class="input_field" onclick="highlight(this);" type="text" style="width: 605px;" value="Thanks to <# SITE_NAME #> for &lt;a href=&quot;<# BASE_URL #>&quot;&gt;free image hosting&lt;/a&gt;" /></td>
					<td>Link to Us</td>
				</tr>
				<tr>
					<td><input readonly="readonly" class="input_field" onclick="highlight(this);" type="text" style="width: 605px;" value="[URL=<# BASE_URL #>][IMG]<# BASE_URL #><# UPLOAD_PATH #><# FILENAME #>[/IMG][/URL]" /></td>
					<td>Hotlink for Forum</td>
				</tr>
				<tr>
					<td><input readonly="readonly" class="input_field" onclick="highlight(this);" type="text" style="width: 605px;" value="&lt;a href=&quot;<# BASE_URL #>&quot;&gt;&lt;img src=&quot;<# BASE_URL #><# UPLOAD_PATH #><# FILENAME #>&quot; border=&quot;0&quot; alt=&quot;<# SITE_NAME #>&quot; /&gt;&lt;/a&gt;" /></td>
					<td>Hotlink for Website</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</template>
<!-- END: FILE RESULTS TABLE -->

<!-- BEGIN: BOXED FILE RESULTS -->
<template id="boxed_file_results">

<if="$mmhclass->funcs->is_null($mmhclass->templ->templ_globals['uploadinfo']) == false">
	<textarea class="input_field" cols="130" rows="25" readonly="readonly" wrap="off" style="width: 940px;">
Direct Links:
    <while id="uploadinfo_whileloop_1">
	<# BASE_URL #><# UPLOAD_PATH #><# FILENAME #>
    </endwhile>
Thumbnails for Website:
    <while id="uploadinfo_whileloop_2">
    &lt;a href=&quot;<# BASE_URL #>viewer.php?file=<# FILENAME #>&quot;&gt;&lt;img src=&quot;<# THUMBNAIL #>&quot; border=&quot;0&quot; alt=&quot;<# FILENAME #>&quot; /&gt;&lt;/a&gt;
    </endwhile>
Thumbnails for Forum:
    <while id="uploadinfo_whileloop_3">
    [URL=<# BASE_URL #>viewer.php?file=<# FILENAME #>][IMG]<# THUMBNAIL #>[/IMG][/URL]
    </endwhile>
Hotlinks for Forum:
    <while id="uploadinfo_whileloop_4">
    [URL=<# BASE_URL #>][IMG]<# BASE_URL #><# UPLOAD_PATH #><# FILENAME #>[/IMG][/URL]
    </endwhile>
Hotlinks for Website:
    <while id="uploadinfo_whileloop_5">
    &lt;a href=&quot;<# BASE_URL #>&quot;&gt;&lt;img src=&quot;<# BASE_URL #><# UPLOAD_PATH #><# FILENAME #>&quot; border=&quot;0&quot; alt=&quot;<# SITE_NAME #>&quot; /&gt;&lt;/a&gt;
    </endwhile>
Link to Us:
	Thanks to <# SITE_NAME #> for &lt;a href=&quot;<# BASE_URL #>&quot;&gt;free image hosting&lt;/a&gt;    
</textarea>
</endif>

<if="$mmhclass->funcs->is_null($mmhclass->templ->templ_globals['errorinfo']) == false">
    <if="$mmhclass->funcs->is_null($mmhclass->templ->templ_globals['uploadinfo']) == false">
    	<hr />
    </endif>
    
    <h1 style="color: #F00;">Warning!</h1><br />
    The following error occurred during uploading:
    <br /><br />
    
    <ul>
    	<while id="errorinfo_whileloop">
        	<li><# ERROR_MESSAGE #></li>
        </endwhile>
	</ul>
</endif>

<if="$mmhclass->funcs->is_null($mmhclass->templ->templ_globals['uploadinfo']) == false">
    <hr />
    
    <div class="table_border">
        <table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
            <tr>
                <th colspan="4">Uploaded Images</th>
            </tr>
            <tr>
                <# GALLERY_HTML #>
            </tr>
            <tr>
                <td colspan="4" class="table_footer">&nbsp;</td>
            </tr>
        </table>
    </div>
</endif>

</template>
<!-- END: BOXED FILE RESULTS -->

<!-- BEGIN: WEBPAGE UPLOAD IMAGE SELECTION -->
<template id="webpage_upload_image_select">

<script type="text/javascript">
	function do_select_all()
	{
		 $("input[name=userfile[]]").each(function()
		 {
			this.checked = ((this.checked == 1) ? 0 : 1);
		 });   
	}
</script>

<div style="height: 10px;">
    <span class="align_left">
        The following images were found at the webpage: <a href="<# WEBPAGE_URL #>" title="<# WEBPAGE_URL #>" target="_blank"><# WEBPAGE_URL_SMALL #></a>.<br />
        Please select the images that you wish to upload and then click "Upload Images."
    </span>
    
    <span class="align_right" style="padding-top: 6px;">
        <a class="button1" onclick="do_select_all();">Select/Deselect All</a>
    </span>
</div>
<br /><br />

<form action="upload.php" method="post" id="upload_form" enctype="multipart/form-data">
	<p>
        <input type="hidden" name="upload_to" value="<# UPLOAD_TO #>" />
        <input type="hidden" name="url_upload_type" value="normal_upload" />
        <input type="hidden" name="upload_type" value="<# UPLOAD_TYPE #>" />
    	<input type="hidden" name="private_upload" value="<# PRIVATE_UPLOAD #>" />
        
        <div class="table_border">
            <table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
                <tr>
                    <th colspan="4">Webpage Scan Results</th>
                </tr>
                <tr>
                    <while id="urlupload_gallery_layout">
                    
                        <# TABLE_BREAK #>
                        <td class="<# TDCLASS #> text_align_center" valign="top">
                            <input type="checkbox" name="userfile[]" value="<# IMAGE_URL #>" checked="checked" />
                            
                            <a href="<# IMAGE_URL #>" target="_blank"><strong><# FILENAME #></strong></a>
                            <br /><br />
                           
                            <a href="<# IMAGE_URL #>" target="_blank"><img src="<# IMAGE_URL #>" alt="<# FILENAME #>" style="max-width: <# MAX_WIDTH #>px;" /></a>
                        </td>
                        
                    </endwhile>
                </tr>
                <tr>
                    <td colspan="4" class="table_footer">
                    	<input type="button" value="Upload Images" class="button1" onclick="toggle_lightbox('index.php?act=upload_in_progress', 'progress_bar_lightbox'); $('form[id=upload_form]').submit();" />
                   	</td>
                </tr>
            </table>
        </div>
	</p>
</form>
    
</template>
<!-- END: WEBPAGE UPLOAD IMAGE SELECTION -->