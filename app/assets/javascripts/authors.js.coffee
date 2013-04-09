# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('body').on('keyup input paste change', 'input#author_image_url', ->
    $('.author_image').attr('src', $('input#author_image_url').val());)