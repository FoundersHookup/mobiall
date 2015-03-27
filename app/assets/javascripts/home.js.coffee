# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#display_edit_form").live "click", ->
    $("#labeled_info").hide()
    $(".interested_form").show()