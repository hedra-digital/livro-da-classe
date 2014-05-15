CKEDITOR.plugins.add( 'generatepdf', {
    icons: 'generatepdf',
    init: function( editor ) {
        editor.addCommand( 'generatePdf', {
            exec: function( editor ) {

                normal_icon=$('.cke_button__generatepdf_icon').css('background-image');
                loading_icon=CKEDITOR.basePath+'plugins/generatepdf/icons/loading.gif';

               // replace icon
               $('.cke_button__generatepdf_icon').css("background-image", "url("+loading_icon+")");
               // disable button
               CKEDITOR.instances.text_content.commands.generatePdf.disable()

               console.log("start download pdf");

               $.ajax({
                url: ask_for_download_pdf_url,
                type: 'PUT', 
                dataType: 'json'
            })
               .done(function(response) {
                $('.cke_button__generatepdf_icon').css("background-image", normal_icon);
                CKEDITOR.instances.text_content.commands.generatePdf.enable()

                console.log("download pdf success");

                // sleep 300ms to let the icon show first
                setTimeout(function(){
                  window.location.replace(response.path);
                  }
                  , 300);
            })
               .fail(function() {
                console.log("download pdf error");
            })
           }
       });
       // add button
       editor.ui.addButton( 'GeneratePdf', {
        label: 'Gerar PDF',
        command: 'generatePdf',
        toolbar: 'editing'
    });
   }
});