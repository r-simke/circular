# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('#newsletter_list tr').dblclick ->
		id = $(this).find('td').first().text()
		window.location = "/newsletters/" + id + "/edit"