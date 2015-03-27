# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".overlay").ajaxStart(->
    $(this).show()
  ).ajaxComplete ->
    $(this).hide()

$(document).ready ->
  $("input[type='submit']").live "click", ->
    id_value = $(this).parent().attr("id")
    $("#requested_user_resource_id").val id_value

  $("#feedback_link").live "click", ->
    id_value = $(this).parent().attr("id")
    $("#requested_user_resource_id").val id_value
    $("form#new_requested_user").attr "action", "/feedbacks"
    $("form#new_requested_user").submit()
