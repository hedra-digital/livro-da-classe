CKEDITOR.plugins.add( 'epigraph', {
    icons: 'epigraph',
    init: function( editor ) {
        editor.addCommand( 'epigraphDialog', new CKEDITOR.dialogCommand( 'epigraphDialog' ) );
        editor.ui.addButton( 'Epigraph', {
            label: 'Insere um epígrafo',
            command: 'epigraphDialog',
            toolbar: 'insert'
        });

        CKEDITOR.dialog.add( 'epigraphDialog', this.path + 'dialogs/epigraph.js' );
    }
});