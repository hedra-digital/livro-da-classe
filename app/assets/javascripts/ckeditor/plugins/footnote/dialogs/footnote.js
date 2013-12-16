CKEDITOR.dialog.add( 'footnoteDialog', function( editor ) {
    return {
        title: 'Notas de Rodapé',
        minWidth: 400,
        minHeight: 200,
        contents: [
            {
                id: 'tab-basic',
                label: 'Parametros Básicos',
                elements: [
                    {
                        type: 'text',
                        id: 'foot-text',
                        label: 'Texto da Nota',
                        validate: CKEDITOR.dialog.validate.notEmpty( "Campo texto da nota de rodapé não pode ser vazio" )
                    }
                ]
            }
        ],
        onOk: function() {
            var dialog = this;

            var footNoteId = (editor.getData().match(/foot-text/g) || []).length + 1;

            var fn = editor.document.createElement( 'sup' );
            fn.setAttribute( 'foot-text', dialog.getValueOf( 'tab-basic', 'foot-text' ) );
            fn.setText( footNoteId );
            fn.setAttribute( 'class', 'footnote-text' );
            editor.insertElement( fn );

            var fnText = "<span class='footnote-show' id='" + footNoteId + "'>";
            fnText += "[" + footNoteId + "] ";
            fnText += dialog.getValueOf( 'tab-basic', 'foot-text' ) + "</span>";

            if ((editor.getData().match(/footnote-hr/g) || []).length == 0){
                editor.setData(editor.getData() + "<hr class='footnote-hr'>" + fnText);
            }
            else{
                editor.setData(editor.getData() + fnText);
            }
        }
    };
});