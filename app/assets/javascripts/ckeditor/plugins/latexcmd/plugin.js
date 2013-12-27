CKEDITOR.plugins.add( 'latexcmd', {
    icons: 'latexcmd',
    init: function( editor ) {
        editor.addCommand( 'latexcmdDialog', new CKEDITOR.dialogCommand( 'latexcmdDialog' ) );
        editor.ui.addButton( 'LatexCmd', {
            label: 'Insere um comando de edição',
            command: 'latexcmdDialog',
            toolbar: 'insert'
        });

        CKEDITOR.dialog.add( 'latexcmdDialog', this.path + 'dialogs/latexcmd.js' );
    }
});