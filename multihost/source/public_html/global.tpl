<!-- BEGIN: GLOBAL GALLERY CELL -->
<template id="global_gallery_layout">

<# TABLE_BREAK #>
<td class="<# TDCLASS #> text_align_center" valign="top">
	<if="$mmhclass->templ->templ_globals['file_options'] == true">
		<input type="checkbox" name="userfile" value="<# FILENAME #>" />
    	<input type="text" id="<# FILE_ID #>_title_rename" maxlength="25" style="width: 165px; display: none;" class="input_field" onblur="gallery_action('rename-d', '<# FILENAME #>', '<# FILE_ID #>');" onkeydown="if(event.keyCode==13){gallery_action('rename-d', '<# FILENAME #>', '<# FILE_ID #>');}" />
		<span class="arial" title="Click to change title" id="<# FILE_ID #>_title" onclick="gallery_action('rename', this.id);" class="font-weight: 700;"><# FILE_TITLE #></span>
	<else>
		<a href="viewer.php?file=<# FILENAME #>" title="<# FILENAME #>"><strong><# FILE_TITLE #></strong></a>
	</endif>
    
    <br /><br />
	<a href="viewer.php?file=<# FILENAME #>"><img src="index.php?module=thumbnail&amp;file=<# FILENAME #>" alt="<# FILENAME #>" /></a>
	<br /><br />
	<a href="download.php?file=<# FILENAME #>"><b>Download Image</b></a> | <a href="javascript:void(0);" onclick="toggle_lightbox('index.php?module=fileinfo&amp;file=<# FILENAME #>', 'file_info_lightbox');"><b>More Info</b></a>
</td>

</template>
<!-- END: GLOBAL GALLERY CELL -->

<!-- BEGIN: GLOBAL MESSAGE BOX -->
<template id="global_message_box">
	
<div class="message_box">
	<# MESSAGE #>
</div>

</template>
<!-- END: GLOBAL MESSAGE BOX -->

<!-- BEGIN: GLOBAL WARNING BOX -->
<template id="global_warning_box">

<div class="message_box">
	<h1>General Notice</h1><br />
	<# ERROR #>
</div>

</template>
<!-- END: GLOBAL WARNING BOX -->

<!-- BEGIN: GLOBAL LIGHTBOX WARNING BOX -->
<template id="global_lightbox_warning">

<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
	<tr>
		<th>&nbsp;</th>
	</tr>
	<tr>
		<td class="message_box">
        	<h1>General Notice</h1><br />
          	<# ERROR #>
		</td>
	</tr>
	<tr>
		<td class="table_footer"><a onclick="$('div[class=lightbox_main]').parent().remove();">Close Window</a></td>
	</tr>
</table>

</template>
<!-- END: GLOBAL LIGHTBOX WARNING BOX -->