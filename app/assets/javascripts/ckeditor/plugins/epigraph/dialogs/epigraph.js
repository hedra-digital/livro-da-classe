CKEDITOR.dialog.add( 'epigraphDialog', function( editor ) {
    return {
        title: 'Epigráfo',
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

            var d = editor.document.createElement('div');            
            d.setAttribute('class','epigraph');

            dText = editor.document.createElement('p');
            dText.setAttribute('class','epigraph-text');
            dText.setText(dialog.getValueOf('tab-basic','epigraph-text'));

            dAuthor = editor.document.createElement('p');
            dAuthor.setAttribute('class','epigraph-author');
            dAuthor.setText(dialog.getValueOf('tab-basic','epigraph-author'));

            d.append(dText);
            d.append(dAuthor);

            editor.insertElement(d);
        }
    };
});