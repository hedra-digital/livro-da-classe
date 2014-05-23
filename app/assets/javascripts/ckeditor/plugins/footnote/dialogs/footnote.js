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

            link = "<a class='footnote'><span>"+ dialog.getValueOf( 'tab-basic', 'foot-text' ) +"</span></a>&nbsp;"
            editor.insertHtml( link );

        }
    };
});