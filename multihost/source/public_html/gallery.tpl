<!-- BEGIN: PUBLIC GALLERY PAGE -->

<span class="align_left_mfix">
	<a href="users.php?act=user_list" class="button1">User Galleries</a>
   
    <if="$mmhclass->input->get_vars['act'] == 'show_rated'">  
        <a href="gallery.php" class="button1">Order by Most Recent</a>
    <else>
    	<a href="gallery.php?act=show_rated" class="button1">Order by Rating</a>
    </endif>
</span>

<# PAGINATION_LINKS #>
<br /><br />

<if="$mmhclass->templ->templ_globals['empty_gallery'] == true">
	<# EMPTY_GALLERY #>
<else>
    <div class="table_border">
        <table cellpadding="4" cellspacing="1" border="0" style="width: 100%;">
            <tr>
                <th colspan="4">Public Gallery</th>
            </tr>
            <tr>
                <td class="tdrow1 text_align_center" colspan="4">
                    The images that are presented below are images that have been uploaded by guest users. For
                    a list of user galleries click the "<a href="users.php?act=user_list">User Galleries</a>" button shown above.
                </td>
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

<!-- END: PUBLIC GALLERY PAGE -->