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
                console.log("download pdf success");
                $('.cke_button__generatepdf_icon').css("background-image", normal_icon);
                CKEDITOR.instances.text_content.commands.generatePdf.enable()

                window.location.replace(response.path);
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