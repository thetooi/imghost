	</div>
    
	<div class="page_footer">
		Powered by <a href="http://www.mihalism.net/multihost/">Mihalism Multi Host</a> |
		
        <a href="info.php?act=privacy_policy">Privacy Policy</a> | 
		<a href="contact.php?act=contact_us">Contact Us</a> |
		
        <a href="http://www.addthis.com/bookmark.php?v=250&amp;pub=xa-4a9728942b1daf7e" class="addthis_button"><img src="http://s7.addthis.com/static/btn/v2/lg-bookmark-en.gif" style="width: 125px; height: 16px;" alt="Bookmark and Share" /></a>
		<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js?pub=xa-4a9728942b1daf7e"></script>
    	
        | Page Views: <# TOTAL_PAGE_VIEWS #> | Page Load: <# PAGE_LOAD #> secs
	</div>
    
    <if="$mmhclass->funcs->is_null("<# GOOGLE_ANALYTICS_ID #>") == false">
		<script type="text/javascript">
			google_stats("<# GOOGLE_ANALYTICS_ID #>");
 		</script>
    </endif>
</body>
</html>