CKEDITOR.plugins.add( 'chapter', {
    icons: 'chapter',
    init: function( editor ) {
        editor.addCommand( 'chapterDialog', new CKEDITOR.dialogCommand( 'chapterDialog' ) );
        editor.ui.addButton( 'Chapter', {
            label: 'Insere um capítulo',
            command: 'chapterDialog',
            toolbar: 'insert'
        });

        CKEDITOR.dialog.add( 'chapterDialog', this.path + 'dialogs/chapter.js' );
    }
});