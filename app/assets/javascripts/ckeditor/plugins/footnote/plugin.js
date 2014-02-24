CKEDITOR.plugins.add( 'footnote', {
    icons: 'footnote',
    init: function( editor ) {
        editor.addCommand( 'footnoteDialog', new CKEDITOR.dialogCommand( 'footnoteDialog' ) );
        editor.ui.addButton( 'FootNote', {
            label: 'Insere uma nota de rodapé',
            command: 'footnoteDialog',
            toolbar: 'insert'
        });

        CKEDITOR.dialog.add( 'footnoteDialog', this.path + 'dialogs/footnote.js' );
    }
});