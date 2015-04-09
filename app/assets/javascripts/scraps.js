// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$( document ).ready(function() {
    $("#scrap_url").live('change', function(){
        if(this.value=="Linkedin.com"){
            $("div.linkedin_fields").show('slow');
        }
        else{
            $("div.linkedin_fields").hide('fast');
        }
    });
});
