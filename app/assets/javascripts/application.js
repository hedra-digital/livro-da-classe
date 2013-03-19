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
//= require jquery-ui
//= require markitup/jquery.markitup
//= require markitup/sets/markdown/set
//= require bootstrap-alert
//= require bootstrap-dropdown
//= require jquery.tipsy
//= require bindWithDelay
//= require reorder
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.pt-BR
//= require_self


// Bootstrap Datepicker
$(document).ready(function() {
  $('[data-behaviour~=datepicker]').datepicker({
    language: 'pt-BR',
    format:   'dd/mm/yyyy'
  });
});

// Tooltips
$(window).load(function() {
  $('.has-tipsy').tipsy({
    gravity: 's',
    fade: true
  });
});
