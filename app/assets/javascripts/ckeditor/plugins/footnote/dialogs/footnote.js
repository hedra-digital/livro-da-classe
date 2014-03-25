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

            var footnotes = (editor.getData().match(/<div id="sdfootnote(.*?)">/g) || []);

            if (footnotes.length == 0){
                footNoteId = 1;
            } else {
                var aux = footnotes.pop();
                aux = aux.match(/\d/g).join("");
                footNoteId = parseInt(aux) + 1;
            }

            var fn = editor.document.createElement( 'a' );            
            fn.setAttribute( 'class', 'sdfootnoteanc' );
            fn.setAttribute( 'href', '#sdfootnote'+ footNoteId +'sym' );
            fn.setAttribute( 'name', 'sdfootnote'+ footNoteId +'anc' );
            fn.setAttribute( 'foot-text', dialog.getValueOf( 'tab-basic', 'foot-text' ) );
            fn.appendHtml("<sup>"+footNoteId+"</sup>");
            editor.insertElement( fn );

            var fnText = "<div id='sdfootnote"+ footNoteId +"'>";
            fnText += "<p class='sdfootnote'>";
            fnText += "<a class='sdfootnotesym' href='#sdfootnote"+ footNoteId +"anc' ";
            fnText += "name='sdfootnote"+ footNoteId +"sym'>";
            fnText += footNoteId + "</a>";
            fnText += dialog.getValueOf( 'tab-basic', 'foot-text' ) + "</p></div>";

            editor.setData(editor.getData() + fnText);
        }
    };
});