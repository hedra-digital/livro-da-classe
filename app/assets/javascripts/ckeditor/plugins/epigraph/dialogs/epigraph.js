CKEDITOR.dialog.add( 'epigraphDialog', function( editor ) {
    return {
        title: 'Epígrafo',
        minWidth: 400,
        minHeight: 200,
        contents: [
            {
                id: 'tab-basic',
                label: 'Parametros Básicos',
                elements: [
                    {
                        type: 'textarea',
                        id: 'epigraph-text',
                        label: 'Texto de Epígrafe',
                        validate: CKEDITOR.dialog.validate.notEmpty( "O texto de epígrafe não pode ser vazio" ),
                        required: true
                    },
                    {
                        type: 'text',
                        id: 'epigraph-author',
                        label: 'Nome do autor'
                    }
                ]
            }
        ],
        onOk: function() {
            var dialog = this;

            var d = editor.document.createElement('section');            
            d.setAttribute('class','epigraph');

            d.setText(dialog.getValueOf('tab-basic','epigraph-text'));

            dAuthorContainer = editor.document.createElement('div');
            
            dAuthor = editor.document.createElement('span');
            dAuthor.setAttribute('class','epigraph-author');
            dAuthor.setText(dialog.getValueOf('tab-basic','epigraph-author'));

            dAuthorContainer.append(dAuthor);
            d.append(dAuthorContainer);

            editor.insertElement(d);
        }
    };
});