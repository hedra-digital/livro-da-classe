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
//= require bootstrap-alert
//= require bootstrap-dropdown
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.pt-BR
//= require bootstrap-fileupload
//= require jquery.tipsy
//= require jquery.fancybox
//= require bindWithDelay
//= require reorder
//= require_self
//= require ckeditor/init
//= require ckeditor/plugins/eqneditor/plugin
//= require ckeditor/plugins/eqneditor/lang/en
//= require ckeditor/plugins/eqneditor/dialogs/eqneditor
//= require ckeditor/plugins/charcount/plugin
//= require ckeditor/plugins/texttransform/plugin
//= require ckeditor/plugins/texttransform/lang/en
//= require ckeditor/plugins/texttransform/lang/pt-BR
//= require ckeditor/plugins/texttransform/lang/tr
//= require ckeditor/plugins/footnote/plugin
//= require jquery.jqEasyCharCounter.min.js
//= require jquery.mask.min.js
//= require jscolor/jscolor
//= require jcrop/jquery.Jcrop

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

// File Upload

$(document).ready(function() {
  $('.fileupload').fileupload();
});

// Fancybox modals

$(document).ready(function() {
  $(".tutorial-modal").fancybox({
    maxWidth    : 800,
    maxHeight   : 600,
    fitToView   : false,
    width       : '70%',
    height      : '70%',
    autoSize    : false,
    closeClick  : false,
    openEffect  : 'none',
    closeEffect : 'none'
  });

  $(".cover-modal").fancybox({
    padding     : 0,
    openEffect  : 'elastic',
    openSpeed   : 150,
    closeEffect : 'elastic',
    closeSpeed  : 150,
    closeClick  : true
  });
});

//recados
$(document).ready(function() {
  $("#botao_enviar").click(function() {
    if($("#text_novo_recado").val().toString().length > 0){
      $.post("/scraps/create", { book: $("#hidden_book_id").val(), content: $("#text_novo_recado").val()}, function( data ) {
        $("#recados table tbody").prepend(data);
      }, 'html');
      $("#text_novo_recado").val('');
    }
  });

  $('#book_zipcode').mask("99999-999");
  
  $('#book_title').jqEasyCounter({
      'maxChars': 54
  });

  $('#book_abstract').jqEasyCounter({
      'maxChars': 1200
  });

  $('#book_cover_info_attributes_texto_quarta_capa').jqEasyCounter({
      'maxChars': 415
  });
  
  $('#book_organizers').jqEasyCounter({
      'maxChars': 25
  });

  $('#book_directors').jqEasyCounter({
      'maxChars': 25
  });

  $('#cover_info_titulo_linha1').jqEasyCounter({
      'maxChars': 20
  });

  $('#cover_info_titulo_linha2').jqEasyCounter({
      'maxChars': 20
  });

  $('#cover_info_titulo_linha3').jqEasyCounter({
      'maxChars': 20
  });

  $('#cover_info_autor').jqEasyCounter({
      'maxChars': 30
  });

  $('#book_keywords').jqEasyCounter({
      'maxChars': 80
  });


});