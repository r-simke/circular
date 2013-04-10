// find out if this a NEW or an EDIT action ..
var url = document.URL.split("/");
// ... and adjust the ajax method (for the SAVE button)
var ajax_type = (url[url.length-1] == "new") ? "POST" : "PUT";
// this is to store the newsletter id for an ajax-call in NEW-action
var newsletter_id = "";

var _changes_made = false;


// initializes tinyMCEs for all (selector) text fields
function initTinyMCE() {
	tinyMCE.init({
		mode: "textarea",
		selector : ".article_text, .newsletter_text, .sidearticle_text",
		onchange_callback : "transferHTML",
		handle_event_callback: "transferHTML",
		theme_advanced_resizing : false,
		theme_advanced_resize_horizontal : true,
		width : "100%"
	});
}

function updateTemplate(callback) {
	var str = $("#newsletter_template_id").find("option:selected").text();
	var url = "/templates/" + str + ".html";
	$("#iframe").attr("src", url);
	$('#iframe').load(function(){
		if(callback != undefined && typeof callback == 'function') callback();
	});
}

// gets author data for selected author from DB
function updateAuthor(callback) {
	var id = $('#newsletter_author_id').find("option:selected").val();
	// AJAX gets author data from DB, writes it to div
	$.get('/authors/' + id + '.json', function(data) {
		var iframe = $('#iframe').contents();
		iframe.find("#auth_img").attr("src", data.image_url);
		iframe.find("#auth_name").text(data.name);
		iframe.find("#auth_tel").text(data.phone+"");
		iframe.find("#auth_title").text(data.title);
		iframe.find(".auth_email").attr("href", "mailto:" + data.email);
		iframe.find(".auth_email_text").text(data.email);

		if(callback != undefined && typeof callback == 'function') callback();
	});
}

function updatePositions(callback) {
	var article_counter = 1;
	var sidearticle_counter = 1;

	$('.article').each(function() {
		var th = $(this);
		positionField = th.find("input[name*='position']");
		positionField.val(article_counter);
		article_counter++;
	});

	$('.sidearticle').each(function() {
		var th = $(this);
		positionField = th.find("input[name*='position']");
		positionField.val(sidearticle_counter);
		sidearticle_counter++;
	});

	if(callback != undefined && typeof callback == 'function') callback();
}

function disableButtons(callback) {
	$(".well").find(".move_up, .move_down").removeClass("disabled");
	$(".sidearticle").first().find(".move_up").addClass("disabled");
	$(".sidearticle").last().find(".move_down").addClass("disabled");
	$(".article").first().find(".move_up").addClass("disabled");
	$(".article").last().find(".move_down").addClass("disabled");
}

function updateArticles(callback) {
	// setting local names for values
	var form_newsletter_text = $('#newsletter_content').val();
	var form_article_texts = $('.article_text');
	var form_sidearticle_texts = $('.sidearticle_text');
	var iframe = $('#iframe').contents();

	//update newsletter welcome text
	iframe.find('#nlWelcomeText').html(form_newsletter_text);

	//update paragraphs
	form_article_texts.each(function() {
		var artid = $(this).parents(".well").find("input[name*=position]").val();
		iframe.find('#article' + artid).find('.pwrapper').html($(this).val());
	});

	//update line classes
	iframe.find('.article').each(function() {
		$(this).find('p').attr('class', '');
		var artid = $(this).attr('id').slice(7, $(this).attr('id').length);
		if( $(".article").find("input[name*=position][value="+artid+"]").parents(".well").find("input[name*='show_dividerline']").val() == "true" ? true : false ) {
			$(this).children().last().attr('class', 'line');
		}
	});

	//update side articles
	form_sidearticle_texts.each(function() {
		var artid = $(this).parents(".well").find("input[name*=position]").val();
		iframe.find('#sidearticle' + artid).find('.pwrapper').html($(this).val());
	});
	if(callback != undefined && typeof callback == 'function') callback();
}

function updateIframe(callback) {
	// setting local names for values
	var form_newsletter_headline = $('#newsletter_topic').val();
	var form_newsletter_text = $('#newsletter_content').val();
	var form_newsletter_outline = ($('#newsletter_show_outline').val() == "true") ? true : false;
	var form_newsletter_divider_line = ($('#newsletter_show_dividerline').val() == "true") ? true : false;
	var form_article_headlines = $('.article_headline');
	var form_article_texts = $('.article_text');
	var form_sidearticle_headlines = $('.sidearticle_headline');
	var form_sidearticle_texts = $('.sidearticle_text');
	var iframe = $('#iframe').contents();
	var iframe_outline_ul = '<ul id="outline"></ul>';

	//update newsletter headline
	iframe.find('#nlHeadline').html(form_newsletter_headline);

	//update newsletter welcome text
	iframe.find('#nlWelcomeText').html(form_newsletter_text);

	//update nl-divider line status
	if(form_newsletter_divider_line) {
		iframe.find("#nlWelcomeText").children().last().attr('class', 'line');
	}

	//update placeholders for articles
	iframe.find('#articleWrapper').empty();
	$(".article").each(function() {
		var artid = $(this).find("input[name*=position]").val();
		iframe.find('#articleWrapper').append("<div id='article" + artid + "' class='article'><a name=" + artid + "></a><h2></h2><div class='pwrapper'></div><p></p></div>");
	});

	//update placeholders for side-articles
	iframe.find('#sideArticleWrapper').empty();
	var i = 0;
	form_sidearticle_headlines.each(function() {
		var artid = $(this).parents(".well").find("input[name*=position]").val();
		if(i == 0) {
			newElement = '<div id="sidearticle' + artid + '" class="sidearticle info-box-content"><h4></h4><div class="pwrapper"><p></p></div></div>';
		} else {
			newElement = '<div class="info-box-middle"><img src="http://adytonsystems.com/newsletter/img/info-box-middle.jpg" alt=""></div><div id="sidearticle' + artid + '" class="sidearticle info-box-content"><h4></h4><div class="pwrapper"><p></p></div></div>';
		}
		iframe.find('#sideArticleWrapper').append(newElement);
		i += 1;
	});

	//update headlines
	form_article_headlines.each(function() {
		var artid = $(this).parents(".well").find("input[name*=position]").val();
		iframe.find('#article' + artid).find('h2').html($(this).val());
	});

	//update paragraphs
	form_article_texts.each(function() {
		var artid = $(this).parents(".well").find("input[name*=position]").val();
		iframe.find('#article' + artid).find('.pwrapper').html($(this).val());
	});

	//update line classes
	iframe.find('.article').each(function() {
		$(this).find('p').attr('class', '');
		var artid = $(this).attr('id').slice(7, $(this).attr('id').length);
		if( $(".article").find("input[name*=position][value="+artid+"]").parents(".well").find("input[name*='show_dividerline']").val() == "true" ? true : false ) {
			$(this).children().last().attr('class', 'line');
		}
	});

	//update outline-status
	if(form_newsletter_outline) {
		var counter = 1;
		if(iframe.find('#outline').length == 0) {
			//no outline found
			iframe.find('.articles').prepend(iframe_outline_ul);
			$('.article').each(function() {
				var headline = $(this).find('.article_headline').val();
				iframe.find('#outline').append('<li><a href="#' + counter + '">' + headline + '</a></li>');
				counter++;
			});
		} else {
			iframe.find('#outline').find('li').remove();
			$('.article').each(function() {
				var headline = $(this).find('.article_headline').val();
				iframe.find('#outline').append('<li><a href="#' + counter + '">' + headline + '</a></li>');
				counter++;
			});
		}
	} else {
		if(iframe.find('#outline').length != 0) {
			iframe.find('#outline').remove();
		}
	}

	//update side articles
	form_sidearticle_headlines.each(function() {
		var artid = $(this).parents(".well").find("input[name*=position]").val();
		iframe.find('#sidearticle' + artid).find('h4').html($(this).val());
	});
	form_sidearticle_texts.each(function() {
		var artid = $(this).parents(".well").find("input[name*=position]").val();
		iframe.find('#sidearticle' + artid).find('.pwrapper').html($(this).val());
	});
	if(callback != undefined && typeof callback == 'function') callback();
}

function updatePre(callback) {
	var prefix = '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"><html>';
	var suffix = '</html>';
	var iframe = $('#iframe').contents();
	var code = Encoder.numEncode(iframe.find("html").html());
	$('#pre').text(prefix + code + suffix);
	// transfer to hidden code field directly
	$("#newsletter_code").val($("#pre").text());

	if(callback != undefined && typeof callback == 'function') callback();
}

// write html from tinymce to textarea, to iframe and then to pre
function transferHTML(callback) {
	var ed = tinymce.activeEditor; // get editor instance
	ed.save(); //save editor content to textarea
	updateIframe(function(){
		
		updateArticles(function(){
			updatePre();
		});
	});
	if(callback != undefined && typeof callback == 'function') callback();
}


// document READY
$(function() {
	updateTemplate(function() {
		updateAuthor();
		updateIframe(function() {
			updatePre();
		})
	});
	initTinyMCE();

	// button functionality instead of checkboxes
	$("button").on('click', function() {
		hidden = $(this).siblings("input[type='hidden']");
		hidden.attr('value', hidden.attr('value') == 'true' ? 'false' : 'true');
	});

	// destroy articles
	$('.newsletter-form').on('click', '.remove_fields', function(event) {
		$(this).prev('input[name*="_destroy"]').val('true');
		$(this).closest('.well').hide();
		updatePositions();
		disableButtons();
		_changes_made = true;
		event.preventDefault();
	});

	// add articles
	$('.newsletter-form').on('click', '.add_fields', function(event){
		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$(this).before($(this).data('fields').replace(regexp, time));
		updatePositions();
		disableButtons();
		initTinyMCE();
		_changes_made = true;
		event.preventDefault();
	});

	// move up article
	$('.newsletter-form').on('click', '.move_up:not(.disabled)', function(event){
		var article = $(this).parents('.article, .sidearticle');
		var before = article.prevAll('.article:first, .sidearticle:first');
		article.slideUp(500, function() {
			article.find('span.mceEditor').remove();
			article.insertBefore(before);
			article.find('.article_text, .sidearticle_text').css('display', 'inline');
			article.slideDown(500, function() {
				initTinyMCE();
				updatePositions(function(){
					updateIframe(function(){
						updatePre();
					});
				});
				disableButtons();
			});
		});
		_changes_made = true;
		event.preventDefault();
	});

	// move down article
	$('.newsletter-form').on('click', '.move_down:not(.disabled)', function(event){
		var article = $(this).parents('.article, .sidearticle');
		var after = article.nextAll('.article:first, .sidearticle:first');
		article.slideUp(500, function() {
			article.find('span.mceEditor').remove();
			article.insertAfter(after);
			article.find('.article_text, .sidearticle_text').css('display', 'inline');
			article.slideDown(500, function() {
				initTinyMCE();
				updatePositions(function(){
					updateIframe(function(){
						updatePre();
					});
				});
				disableButtons();
			});
		});
		_changes_made = true;
		event.preventDefault();
	});

	//change template
	$('#newsletter_template_id').change(function() {
		updateTemplate(function() {
			updateAuthor(function() {
				updatePre();
				_changes_made = true;
			});
		});
	});

	//change author
	$('#newsletter_author_id').change(function() {
		updateAuthor(function() {
			updatePre();
			_changes_made = true;
		});
	});

	//update iframe on key
	$('.newsletter-form').on('keyup input paste change click', 'textarea, input:not([type=submit]), select, button:not(.submit)', function(evt) {
		updateIframe(function(){
			updatePre();
			_changes_made = true;
		});
	});

	// change between preview and code
	$('body').on('click', '#code', function(evt){
		evt.preventDefault();
		$('#preview').removeClass('active');
		$('#code').addClass('active');
		$('#iframe').hide();
		$('#precontainer').show();
	});

	// change between preview and code
	$('body').on('click', '#preview', function(evt){
		evt.preventDefault();
		$('#code').removeClass('active');
		$('#preview').addClass('active');
		$('#iframe').show();
		$('#precontainer').hide();
	});

	// SAVE AND EXIT: no warning!
	$('.newsletter-form').on('click', '.save-and-exit', function(evt){
		_changes_made = false;
		});

	// SAVE
	$('.newsletter-form').on('click', '.save', function(evt){
		evt.preventDefault();
		var valuesToSubmit = $('form').serialize();
		ajax_url = (newsletter_id == "") ? $('form').attr('action') : $('form').attr('action') + "/" + newsletter_id + "/";
		$.ajax({
			url: ajax_url,
			data: valuesToSubmit,
			type: ajax_type,
			dataType: "JSON"
		}).success(function(json){
			_changes_made = false;
			if(json){					
				$("input#newsletter_id").val(json.id);
				newsletter_id = json.id;
				ajax_type = "PUT";
			}
			$('<div class="alert alert-success">Newsletter stored</div>"').hide().appendTo('body').fadeIn("fast").delay(1000).fadeOut("slow", function() {
				$(this).remove();
			});
		});
	});

	$(window).bind('beforeunload', function() {
		if (_changes_made){
			return 'There are unsaved changes which will be lost if you continue.';
		}
	});

});