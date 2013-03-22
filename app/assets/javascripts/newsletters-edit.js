// initializes tinyMCEs for all (selector) text fields
function initTinyMCE() {
	tinyMCE.init({
		mode: "textarea",
		selector : ".article_text, .newsletter_text, .side_article_text",
		onchange_callback : "transferHTML",
		handle_event_callback: "transferHTML",
		theme_advanced_resizing : false,
		theme_advanced_resize_horizontal : true,
		width : "100%"
	});
}

$(function() {
	initTinyMCE();

// button functionality instead of checkboxes
$("button").on('click', function() {
	hidden = $(this).siblings("input[type='hidden']");
	hidden.attr('value', hidden.attr('value') == 'true' ? 'false' : 'true');
});

});