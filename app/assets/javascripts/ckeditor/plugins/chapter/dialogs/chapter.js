CKEDITOR.dialog.add( 'chapterDialog', function( editor ) {
    return {
        title: 'Capítulo',
        minWidth: 400,
        minHeight: 200,
        contents: [
            {
                id: 'tab-basic',
                label: 'Parametros Básicos',
                elements: [
                    {
                        type: 'text',
                        id: 'chapter-title',
                        label: 'Título',
                        validate: CKEDITOR.dialog.validate.notEmpty( "O texto de título não pode ser vazio" ),
                        required: true
                    },
                    {
                        type: 'text',
                        id: 'chapter-subtitle',
                        label: 'Subtítulo'
                    },
                    {
                        type: 'text',
                        id: 'chapter-author',
                        label: 'Autor'
                    }
                ]
            }
        ],
        onOk: function() {
            var dialog = this;

            var d = editor.document.createElement('section');
            d.setAttribute('class','chapter');

            var dTitle = editor.document.createElement('h1');
            dTitle.setText(dialog.getValueOf('tab-basic','chapter-title'));

            var dSubtitle = editor.document.createElement('h3');
            dSubtitle.setText(dialog.getValueOf('tab-basic','chapter-subtitle'));

            var dAuthor = editor.document.createElement('p');
            dAuthor.setText(dialog.getValueOf('tab-basic','chapter-author'));

            d.append(dTitle);
            d.append(dSubtitle);
            d.append(dAuthor);

            editor.insertElement(d);
        }
    };
});