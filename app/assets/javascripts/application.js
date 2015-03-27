// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.cookie
//= require twitter/bootstrap
//= require_tree .

function change_form_action() {
    $("form#new_requested_user").attr("action","/feedbacks") ;
    $("form#new_requested_user").submit();
}


$(document).ready(function() {
   if($.cookie("user_first_name")) {
       $("#requested_user_first_name").val($.cookie("user_first_name"));
   }
   if($.cookie("user_last_name")) {
       $("#requested_user_last_name").val($.cookie("user_last_name"));
   }
   if($.cookie("user_email")) {
       $("#requested_user_email").val($.cookie("user_email"));
   }
   if($.cookie("user_company_name")) {
       $("#requested_user_company_name").val($.cookie("user_company_name"));
   }

   $("[type='submit']").live('click', function(){
       $("#new_requested_user").attr("action","/requested_users") ;
   });
})
