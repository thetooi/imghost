<!-- BEGIN: FILE INFO LIGHTBOX -->

<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
	<tr>
		<th colspan="2">Image Meta Information & Preview</th>
	</tr>
	<tr>
		<td class="tdrow1 text_align_center" colspan="2" height="<# THUMBNAIL_HEIGHT #>px;">
        	<a href="<# UPLOAD_PATH #><# FILENAME #>"><img src="index.php?module=thumbnail&amp;file=<# FILENAME #>" alt="<# FILENAME #> Thumbnail" /></a>
        </td>
	</tr>
	<tr>
		<td style="width: 44%;" class="tdrow1"><span class="arial">Original Filename:</span></td>
		<td class="tdrow2"><a href="viewer.php?file=<# FILENAME #>"><# REAL_FILENAME #></a></td>
	</tr>
	<tr>
		<td style="width: 44%;" class="tdrow1"><span class="arial">Dimensions:</span></td>
		<td class="tdrow2"><# IMAGE_WIDTH #> x <# IMAGE_HEIGHT #> Pixels (Width by Height)</td>
	</tr>
	<tr>
		<td style="width: 44%;" class="tdrow1"><span class="arial">Mime Type:</span></td>
		<td class="tdrow2"><a href="http://www.fileinfo.com/extension/<# FILE_EXTENSION #>"><# MIME_TYPE #></a></td>
	</tr>
	<tr>
		<td style="width: 44%;" class="tdrow1"><span class="arial">Date Uploaded:</span></td>
		<td class="tdrow2"><# DATE_UPLOADED #></td>
	</tr>
	<tr>
		<td style="width: 44%;" class="tdrow1"><span class="arial">Total Filesize:</span></td>
		<td class="tdrow2"><# TOTAL_FILESIZE #></td>
	</tr>
    
    <if="$mmhclass->info->is_admin == true && $mmhclass->info->config['proxy_images'] == true">
        <tr>
            <td style="width: 44%;" class="tdrow1"><span class="arial">Bandwidth Usage:</span></td>
            <td class="tdrow2"><# BANDWIDTH_USAGE_FORMATTED #></td>
        </tr>
    </endif>
    
	<tr>
		<td style="width: 44%;" class="tdrow1"><span class="arial">Rating:</span></td>
		<td class="tdrow2"><img src="index.php?module=rating&file=<# FILENAME #>" style="vertical-align: -20%" alt="File Rating" /> ( <# TOTAL_RATINGS #> Votes )</td>
	</tr>
	<tr>
		<td colspan="2" class="table_footer"><a onclick="toggle_lightbox('no_url', '<# LIGHTBOX_ID #>');">Close Window</a></td>
	</tr>
</table>

<!-- END: FILE INFO LIGHTBOX -->