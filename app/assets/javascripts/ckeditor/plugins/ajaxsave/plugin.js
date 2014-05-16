CKEDITOR.plugins.add( 'ajaxsave', {
    icons: 'ajaxsave',
    init: function( editor ) {
        editor.addCommand( 'ajaxSave', {
            exec: function( editor ) {

               normal_icon=$('.cke_button__ajaxsave_icon').css('background-image');
               loading_icon=CKEDITOR.basePath+'plugins/ajaxsave/icons/loading.gif';

               // replace icon
               $('.cke_button__ajaxsave_icon').css("background-image", "url("+loading_icon+")");
               // disable button
               CKEDITOR.instances.text_content.commands.ajaxSave.disable()
               // update the text to the form
               CKEDITOR.instances.text_content.updateElement()

               console.log("start updae text");

               $.ajax({
                url: $("form").first().attr("action"),
                type: 'PUT', 
                dataType: 'json',
                data: $("form").first().serialize()
            })
               .done(function(response) {
                // turn it back
                $('.cke_button__ajaxsave_icon').css("background-image", normal_icon);
                CKEDITOR.instances.text_content.commands.ajaxSave.enable()
                console.log("updae text success");
            })
               .fail(function() {
                console.log("updae text error");
            })
               .always(function() {

            });
           }
       });

       // add button
       editor.ui.addButton( 'AjaxSave', {
        label : 'Salvar',
        command: 'ajaxSave',
        toolbar: 'editing'
    });
   }
});
