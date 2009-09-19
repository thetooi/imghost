<!-- BEGIN: MAIN VIEWER PAGE -->

<if="$mmhclass->templ->templ_globals['new_file_rating'] == true">
	<# NEW_RATING_HTML #><hr />
</endif>

<div class="text_align_center">
	<if="$mmhclass->funcs->is_null($mmhclass->input->get_vars['is_random']) == false">
		<a href="index.php?do_random=1" class="button1">New Random Image</a>
        <br /><br />
	</endif>
	
	<a href="<# UPLOAD_PATH #><# FILENAME #>"><img src="<# UPLOAD_PATH #><# FILENAME #>" alt="<# REAL_FILENAME #>" style="border: 1px dashed #000000; padding: 2px; <# IMAGE_RESIZE #>" /></a>

	<if="$mmhclass->templ->templ_globals['file_info']['width'] > 940">
		<br /><br />
		<b>Resize</b>: The above image has been resized to better fit your screen. To view its <a href="<# UPLOAD_PATH #><# FILENAME #>">true size</a>, click it.
	</endif>
</div><hr />

<div class="align_left_mfix">
    <a href="download.php?file=<# FILENAME #>" class="button1">Download Image</a> 
    <a href="contact.php?act=file_report&amp;file=<# FILENAME #>" class="button1">Report Image</a> 
    <span onclick="toggle('file_rating_block');" class="button1">Rate Image</span>
    <a href="links.php?file=<# FILENAME #>" class="button1">Image Links</a>
    
    <if="$mmhclass->info->is_user == true">
    	<a href="javascript:void(0);" onclick="toggle_lightbox(('admin.php?act=delete_files&amp;files=' + encodeURIComponent('<# FILENAME #>')), 'delete_files_lightbox');" class="button1">Delete Image</a>
    </endif>
</div>

<div class="align_right_mfix">
	<a href="http://www.addthis.com/bookmark.php?v=250&amp;pub=xa-4a982a3323ec2793" class="addthis_button button1">Share Image</a>
	<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js?pub=xa-4a982a3323ec2793"></script>
</div>
<br /><br />

<div id="file_rating_block" style="display: none;">
	<div class="table_border">
		<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
			<tr>
				<th colspan="2">File Rating</th>
			</tr>
			<tr>
				<td style="width: 44%;" class="tdrow1">&nbsp;</td>
				<td style="width: 56%;" class="tdrow1">
					Rate This Image: 
					<br /><br />
                    
					<form action="viewer.php?act=rate_it&amp;file=<# FILENAME #>" method="post">
						<p>
							<input type="radio" name="rating_id" value="5" /> <img src="css/images/ratings/22222.png" alt="Excellent!" style="vertical-align: -20%;" /> Excellent!<br />
							<input type="radio" name="rating_id" value="4" /> <img src="css/images/ratings/22220.png" alt="Very Good" style="vertical-align: -20%;" /> Very Good<br />
							<input type="radio" name="rating_id" value="3" checked="checked" /> <img src="css/images/ratings/22200.png" alt="Good" style="vertical-align: -20%;" /> Good<br />
							<input type="radio" name="rating_id" value="2" /> <img src="css/images/ratings/22000.png" alt="Fair" style="vertical-align: -20%;" /> Fair<br />
							<input type="radio" name="rating_id" value="1" /> <img src="css/images/ratings/20000.png" alt="Poor" style="vertical-align: -20%;" /> Poor
							<br /><br />
                            
							<input type="submit" value="Rate It!" class="button1" />
							<input type="button" value="Cancel" class="button1" onclick="toggle('file_rating_block');" />
						</p>
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="table_footer">&nbsp;</td>
			</tr>
		</table>
	</div><hr />
</div>

<div class="table_border">
	<table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
		<tr>
			<th colspan="2">Image Meta Information</th>
		</tr>
		<tr>
			<td style="width: 44%" class="tdrow1"><span class="arial">Original Filename:</span></td>
			<td class="tdrow2"><a href="<# UPLOAD_PATH #><# FILENAME #>"><# REAL_FILENAME #></a></td>
		</tr>
		<tr>
			<td style="width: 44%" class="tdrow1"><span class="arial">Dimensions:</span></td>
			<td class="tdrow2"><# IMAGE_WIDTH #> x <# IMAGE_HEIGHT #> Pixels (Width by Height)</td>
		</tr>
        
		<if="<# VIEWER_CLICKS #> > 1">
			<tr>
				<td style="width: 44%" class="tdrow1"><span class="arial">Clicks to Page:</span></td>
				<td class="tdrow2"><# VIEWER_CLICKS #> External Clicks</td>
			</tr>
		</endif>
        
        <if="<# IMAGE_VIEWS #> > 1 && $mmhclass->info->config['proxy_images'] == true">
			<tr>
				<td style="width: 44%" class="tdrow1"><span class="arial">Image Views:</span></td>
				<td class="tdrow2"><# IMAGE_VIEWS #></td>
			</tr>
        </endif>
        
		<if="$mmhclass->funcs->is_null($mmhclass->templ->templ_globals['file_info']['comment']) == true">
			<tr>
				<td style="width: 44%" class="tdrow1"><span class="arial">Mime Type:</span></td>
				<td class="tdrow2"><a href="http://www.fileinfo.com/extension/<# FILE_EXTENSION #>"><# MIME_TYPE #></a></td>
			</tr>
		<else>
			<tr>
				<td style="width: 44%" class="tdrow1"><span class="arial">Meta Comment:</span></td>
				<td class="tdrow2"><# HIDDEN_COMMENT #></td>
			</tr>
		</endif>
		
		<tr>
			<td style="width: 44%" class="tdrow1"><span class="arial">Date Uploaded:</span></td>
			<td class="tdrow2"><# DATE_UPLOADED #></td>
		</tr>
		<tr>
			<td style="width: 44%" class="tdrow1"><span class="arial">Total Filesize:</span></td>
			<td class="tdrow2"><# TOTAL_FILESIZE #></td>
		</tr>
		<tr>
			<td style="width: 44%" class="tdrow1"><span class="arial">Rating:</span></td>
			<td class="tdrow2"><img src="index.php?module=rating&amp;file=<# FILENAME #>" style="vertical-align: -20%;" alt="File Rating" /> ( <# TOTAL_RATINGS #> Votes )</td>
		</tr>
		<tr>
			<td colspan="2" class="tdrow2"><# FILE_LINKS #></td>
		</tr>
		<tr>
			<td colspan="2" class="table_footer">&nbsp;</td>
		</tr>
	</table>
</div>

<!-- END: MAIN VIEWER PAGE -->