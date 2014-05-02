CKEDITOR.plugins.add( 'generatepdf', {
    icons: 'generatepdf',
    init: function( editor ) {
        editor.addCommand( 'generatePdf', {
            exec: function( editor ) {
                generate("pdf");
            }
        });
        editor.ui.addButton( 'GeneratePdf', {
            label: 'Generate Pdf',
            command: 'generatePdf',
            toolbar: 'editing'
        });
    }
});